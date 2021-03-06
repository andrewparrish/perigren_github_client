
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "perigren_github_client/version"

Gem::Specification.new do |spec|
  spec.name          = "perigren_github_client"
  spec.version       = PerigrenGithubClient::VERSION
  spec.authors       = ["Andrew Parrish"]
  spec.email         = ["m.andrewparrish@gmail.com"]

  spec.summary       = %q{Github API Client for Github App}
  spec.description   = %q{Github API Client for Github App Authentication based Requests}
  spec.homepage      = "https://timely-reviews.com"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.16.1"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_dependency "excon", ">= 0.71.0"
  spec.add_dependency "openssl"
  spec.add_dependency "jwt"
end
