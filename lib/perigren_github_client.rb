require "perigren_github_client/version"
require 'perigren_github_client/client'
require 'perigren_github_client/pull_request_client'

module PerigrenGithubClient
  def self.connect(app_id, installation_id = nil, token = nil)
    return Client.new(app_id, installation_id, token)
  end
end
