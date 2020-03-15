# -*- encoding: utf-8 -*-
# stub: typescript-rails 0.6.2.4 ruby lib

Gem::Specification.new do |s|
  s.name = "typescript-rails".freeze
  s.version = "0.6.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["FUJI, Goro".freeze, "Klaus Zanders".freeze]
  s.date = "2016-09-12"
  s.description = "Adds Typescript to the Rails Asset pipeline".freeze
  s.email = ["gfuji@cpan.org".freeze, "klaus.zanders@gmail.com".freeze]
  s.homepage = "https://github.com/typescript-ruby/typescript-rails".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "3.0.6".freeze
  s.summary = "Adds Typescript to the Rails Asset pipeline".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<typescript-node>.freeze, [">= 1.6.2"])
      s.add_runtime_dependency(%q<tilt>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<railties>.freeze, [">= 0"])
    else
      s.add_dependency(%q<typescript-node>.freeze, [">= 1.6.2"])
      s.add_dependency(%q<tilt>.freeze, [">= 0"])
      s.add_dependency(%q<railties>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<typescript-node>.freeze, [">= 1.6.2"])
    s.add_dependency(%q<tilt>.freeze, [">= 0"])
    s.add_dependency(%q<railties>.freeze, [">= 0"])
  end
end
