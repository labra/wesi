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
  gem.name = "wesi"
  gem.homepage = "http://github.com/labra/wesi"
  gem.license = "MIT"
  gem.summary = %Q{Wesi - Semantic Web DSL}
  gem.description = %Q{WESI - Semantic Web DSL}
  gem.email = "labra@uniovi.es"
  gem.authors = ["Jose Emilio Labra Gayo"]
  gem.version = "0.0.5"
  # dependencies defined in Gemfile
  gem.add_dependency 'ruby-graphviz', '>=1.0.0'
  gem.add_dependency 'rest-client',   '>=1.6.7'
  
  gem.executables = ["rdf2gv"]
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
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "wesi #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
