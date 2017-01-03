# -*- encoding: utf-8 -*-
# stub: elasticsearch-ruby 0.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "elasticsearch-ruby".freeze
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Edmund Salvacion".freeze]
  s.date = "2012-06-12"
  s.description = "Ruby Driver for Elastic Search".freeze
  s.email = ["edmund@edmundatwork.com".freeze]
  s.homepage = "".freeze
  s.rubyforge_project = "elasticsearch".freeze
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Ruby Driver for Elastic Search".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<thrift>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3.0.0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_development_dependency(%q<turn>.freeze, [">= 0"])
    else
      s.add_dependency(%q<thrift>.freeze, [">= 0"])
      s.add_dependency(%q<activesupport>.freeze, [">= 3.0.0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_dependency(%q<turn>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<thrift>.freeze, [">= 0"])
    s.add_dependency(%q<activesupport>.freeze, [">= 3.0.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<turn>.freeze, [">= 0"])
  end
end
