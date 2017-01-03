# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "elastic_search/version"

Gem::Specification.new do |s|
  s.name        = "elasticsearch-ruby"
  s.version     = ElasticSearch::VERSION
  s.authors     = ["Edmund Salvacion"]
  s.email       = ["edmund@edmundatwork.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby Driver for Elastic Search}
  s.description = %q{Ruby Driver for Elastic Search}

  s.rubyforge_project = "elasticsearch"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # = Library dependencies
  #
  s.add_dependency 'thrift'
  s.add_dependency 'activesupport', ">= 3.0.0"
  s.add_development_dependency "rake"
  s.add_development_dependency "minitest"
  s.add_development_dependency "turn"
end
