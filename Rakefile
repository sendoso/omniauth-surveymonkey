require 'bundler/gem_tasks'

desc "Build the gem"
task :build do
  system "gem build surveymonkey-omniauth.gemspec"
end

desc "Build and release the gem"
task :release => :build do
  system "gem push surveymonkey-omniauth-#{OmniAuth::Surveymonkey::VERSION}.gem"
end
