require File.expand_path('../lib/omniauth/surveymonkey/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'omniauth'
  gem.add_dependency 'oauth2'
  gem.add_dependency 'omniauth-oauth2'

  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'

  gem.authors = ["Ahmad Ali"]
  gem.email = ["ahmad.ali@sendoso.com"]
  gem.description = %q{Survemonkey OAuth2 strategy for OmniAuth}
  gem.summary = %q{Survemonkey OAuth2 strategy for OmniAuth}


  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files spec/*`.split("\n")
  gem.name = "omniauth-surveymonkey"
  gem.require_paths = ["lib"]
  gem.version = OmniAuth::Surveymonkey::VERSION
  gem.homepage = "https://github.com/sendoso/omniauth-surveymonkey"
  gem.license = 'MIT'
end
