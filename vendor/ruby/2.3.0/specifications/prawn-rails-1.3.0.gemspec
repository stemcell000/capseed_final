# -*- encoding: utf-8 -*-
# stub: prawn-rails 1.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "prawn-rails".freeze
  s.version = "1.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Carlos Ortiz".freeze, "Weston Ganger".freeze]
  s.date = "2019-08-07"
  s.description = "Prawn Handler for Rails. Handles and registers pdf formats.".freeze
  s.email = "weston@westonganger.com".freeze
  s.homepage = "https://github.com/cortiz/prawn-rails".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "3.0.6".freeze
  s.summary = "Prawn Handler for Rails".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<prawn>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<prawn-table>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<rails>.freeze, [">= 3.1.0"])
      s.add_development_dependency(%q<pdf-reader>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
    else
      s.add_dependency(%q<prawn>.freeze, [">= 0"])
      s.add_dependency(%q<prawn-table>.freeze, [">= 0"])
      s.add_dependency(%q<rails>.freeze, [">= 3.1.0"])
      s.add_dependency(%q<pdf-reader>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<prawn>.freeze, [">= 0"])
    s.add_dependency(%q<prawn-table>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, [">= 3.1.0"])
    s.add_dependency(%q<pdf-reader>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
  end
end
