# -*- encoding: utf-8 -*-
# stub: jemoji 0.6.2 ruby lib

Gem::Specification.new do |s|
  s.name = "jemoji"
  s.version = "0.6.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["GitHub, Inc."]
  s.date = "2016-03-19"
  s.email = "support@github.com"
  s.homepage = "https://github.com/jekyll/jemoji"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.7"
  s.summary = "GitHub-flavored emoji plugin for Jekyll"

  s.installed_by_version = "2.4.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jekyll>, [">= 3.0"])
      s.add_runtime_dependency(%q<html-pipeline>, ["~> 2.2"])
      s.add_runtime_dependency(%q<gemoji>, ["~> 2.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
    else
      s.add_dependency(%q<jekyll>, [">= 3.0"])
      s.add_dependency(%q<html-pipeline>, ["~> 2.2"])
      s.add_dependency(%q<gemoji>, ["~> 2.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<jekyll>, [">= 3.0"])
    s.add_dependency(%q<html-pipeline>, ["~> 2.2"])
    s.add_dependency(%q<gemoji>, ["~> 2.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
  end
end
