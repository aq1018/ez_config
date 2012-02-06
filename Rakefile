# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "ez_config"
  gem.homepage = "http://github.com/aq1018/ez_config"
  gem.license = "MIT"
  gem.summary = %Q{load yml files from specified path and easily access your config data.}
  gem.description = %Q{ez_config loads yml files from specified path and allows you to easily access your config data.}
  gem.email = "aq1018@gmail.com"
  gem.authors = ["Aaron Qian"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
  spec.rspec_opts = "--color --format progress"
end

if RUBY_VERSION =~ /^1\.9/
  desc "Code coverage detail"
  task :simplecov do
    ENV['COVERAGE'] = "true"
    Rake::Task[:spec].execute
  end
elsif  RUBY_VERSION =~ /^1\.8/
  RSpec::Core::RakeTask.new(:rcov) do |spec|
    spec.pattern = 'spec/**/*_spec.rb'
    spec.rcov = true
    spec.rcov_opts = "--exclude ~\/.rvm,spec"
  end
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
