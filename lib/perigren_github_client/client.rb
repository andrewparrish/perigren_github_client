require 'excon'
require 'openssl'
require 'jwt'
require 'pry'
require 'json'
require 'perigren_github_client/pull_request_client'

module PerigrenGithubClient
  BASE_URL = 'https://api.github.com' 

  class Client
    include PullRequestClient

    attr_reader :token_data

    def initialize(app_id, installation_id = nil, token = nil,
                   private_pem = ENV['GITHUB_PRIVATE_KEY'].gsub("\\n", "\n"), jwt = nil)
      @app_id = app_id
      @connection = Excon.new('https://api.github.com/app', :persistent => false)
      unless token
        @jwt = jwt || fetch_jwt(private_pem)
        @installation_id = installation_id || fetch_installation_id
      else
        @installation_id = installation_id
      end
      token = { token: token } if token
      @token_data = token || fetch_token
    end

    def get(url)
      request = Excon.get(url, headers: base_headers.merge(token_header))
      JSON.parse(request.body)
    end

    private

    def fetch_jwt(private_pem)
      private_key = OpenSSL::PKey::RSA.new(private_pem)
      payload = {
        # issued at time
        iat: Time.now.to_i,
        # JWT expiration time (10 minute maximum)
        exp: Time.now.to_i + (9 * 60),
        # GitHub App's identifier
        iss: @app_id
      }

      JWT.encode(payload, private_key, "RS256")
    end

    def base_headers
      { 'Accept' => 'application/vnd.github.machine-man-preview+json', 'User-Agent' => 'ruby' }
    end

    def private_jwt_header
      { 'Authorization' => "Bearer #{@jwt}" }
    end

    def token_header
      { 'Authorization' => "token #{@token_data[:token]}" }
    end

    def fetch_installation_id
      request = Excon.get('https://api.github.com/app/installations', headers: base_headers.merge(private_jwt_header))
      JSON.parse(request.body)[0]['id']
    end

    def fetch_token
      request = Excon.post(BASE_URL + "/app/installations/#{@installation_id}/access_tokens", headers: base_headers.merge(private_jwt_header))
      token_data = JSON.parse(request.body)
      @token_data = { token: token_data['token'], expires: token_data['expires_at'] }
    end
  end
end
