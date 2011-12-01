# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{wesi}
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Jose Emilio Labra Gayo}]
  s.date = %q{2011-11-30}
  s.description = %q{WESI - Semantic Web DSL}
  s.email = %q{labra@uniovi.es}
  s.executables = [%q{rdf2gv}]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "bin/rdf2gv.rb",
    "bin/wesi_server",
    "data/ex1.ttl",
    "data/ex1bis.ttl",
    "lib/prefixTable.json",
    "lib/rdf2gv.rb",
    "lib/rdfGraph.rb",
    "lib/test1.rb",
    "lib/wesi.rb",
    "lib/wesi/version.rb",
    "test/helper.rb",
    "test/test_wesi.rb"
  ]
  s.homepage = %q{http://github.com/labra/wesi}
  s.licenses = [%q{MIT}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.9}
  s.summary = %q{Wesi - Semantic Web DSL}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_runtime_dependency(%q<ruby-graphviz>, [">= 1.0.0"])
      s.add_runtime_dependency(%q<rest-client>, [">= 1.6.7"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<ruby-graphviz>, [">= 1.0.0"])
      s.add_dependency(%q<rest-client>, [">= 1.6.7"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<ruby-graphviz>, [">= 1.0.0"])
    s.add_dependency(%q<rest-client>, [">= 1.6.7"])
  end
end
