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
  gem.name = "polymorphic_alternative"
  gem.homepage = "http://github.com/software-project/polymorphic_alternative"
  gem.license = "MIT"
  gem.summary = %Q{Better alternative for polymorphic relations in rails}
  gem.description = %Q{Gem adds belongs to relations and function agregation function for getting one of them. It is better way for doing polymorphic relations because we can constrain database and keep it integrity.}
  gem.email = "m.jedras@software-project.pl"
  gem.authors = ["Martin"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : "0.0.1"

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "polymorphic_alternative #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
