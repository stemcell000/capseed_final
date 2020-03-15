# -*- encoding: utf-8 -*-
# stub: active_admin_import 3.0.0.pre ruby lib

Gem::Specification.new do |s|
  s.name = "active_admin_import".freeze
  s.version = "3.0.0.pre"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Igor Fedoronchuk".freeze]
  s.date = "2015-11-19"
  s.description = "The most efficient way to import for Active Admin".freeze
  s.email = ["fedoronchuk@gmail.com".freeze]
  s.homepage = "http://github.com/Fivell/active_admin_import".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.6".freeze
  s.summary = "ActiveAdmin import based on activerecord-import gem.".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord-import>.freeze, ["~> 0.8.0"])
      s.add_runtime_dependency(%q<rchardet>.freeze, ["~> 1.5"])
      s.add_runtime_dependency(%q<rubyzip>.freeze, ["~> 1.0", ">= 1.0.0"])
      s.add_runtime_dependency(%q<rails>.freeze, [">= 4.0"])
    else
      s.add_dependency(%q<activerecord-import>.freeze, ["~> 0.8.0"])
      s.add_dependency(%q<rchardet>.freeze, ["~> 1.5"])
      s.add_dependency(%q<rubyzip>.freeze, ["~> 1.0", ">= 1.0.0"])
      s.add_dependency(%q<rails>.freeze, [">= 4.0"])
    end
  else
    s.add_dependency(%q<activerecord-import>.freeze, ["~> 0.8.0"])
    s.add_dependency(%q<rchardet>.freeze, ["~> 1.5"])
    s.add_dependency(%q<rubyzip>.freeze, ["~> 1.0", ">= 1.0.0"])
    s.add_dependency(%q<rails>.freeze, [">= 4.0"])
  end
end
