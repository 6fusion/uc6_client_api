require 'rubygems/package_task'

PKG_FILES = FileList[
  '{lib}/**/*'
]

Gem::Specification.new do |s|
  s.name = "uc6_client_api"
  s.version = "0.1.2"
  s.summary = "Client library for interacting with the 6Fusion API."
  s.description = "A basic library for making the appropriate 6Fusion API calls"
  s.authors = ["Ryan Bloom"]
  s.email = "rbloom@6fusion.com"
  s.files = PKG_FILES.to_a
  s.homepage = "https://github.com/6fusion/uc6_client_api"
  s.platform = Gem::Platform::RUBY
  s.add_runtime_dependency 'faraday', '~> 0.9'
  s.add_runtime_dependency 'faraday_middleware', '~> 0.9'
  s.licenses = "Apache-2.0"
end
