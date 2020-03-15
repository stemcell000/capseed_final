# -*- encoding: utf-8 -*-
# stub: jasny-bootstrap-rails 3.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "jasny-bootstrap-rails".freeze
  s.version = "3.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Benjamin H\u{fc}ttinger".freeze]
  s.date = "2015-02-26"
  s.description = "Rails Gegm to extends Bootstrap with some additional features. Source http://jasny.github.io/bootstrap/".freeze
  s.email = ["benjamin.huettinger@gmail.com".freeze]
  s.homepage = "https://github.com/maxigs/jasny-bootstrap-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.6".freeze
  s.summary = "Rails Gegm to extends Bootstrap with some additional features. Source http://jasny.github.io/bootstrap/".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3.0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.0"])
    else
      s.add_dependency(%q<railties>.freeze, [">= 3.0"])
      s.add_dependency(%q<bundler>.freeze, [">= 1.0"])
    end
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.0"])
  end
end
