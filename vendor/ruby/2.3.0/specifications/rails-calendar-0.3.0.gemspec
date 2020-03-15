# -*- encoding: utf-8 -*-
# stub: rails-calendar 0.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-calendar".freeze
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Rodrigo D\u{ed}az V.".freeze]
  s.date = "2014-09-01"
  s.description = "An easy to use calendar for your rails app".freeze
  s.email = ["rdiazv89@gmail.com".freeze]
  s.homepage = "https://github.com/rdiazv/rails_calendar".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.6".freeze
  s.summary = "An easy to use calendar for your rails app".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>.freeze, [">= 3.0"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 3.0.2"])
      s.add_development_dependency(%q<rspec-legacy_formatters>.freeze, ["~> 1.0.0"])
      s.add_development_dependency(%q<guard>.freeze, ["~> 2.6.1"])
      s.add_development_dependency(%q<guard-rspec>.freeze, ["~> 4.3.1"])
      s.add_development_dependency(%q<coveralls>.freeze, ["~> 0.7.1"])
      s.add_development_dependency(%q<capybara>.freeze, ["~> 2.4.1"])
    else
      s.add_dependency(%q<rails>.freeze, [">= 3.0"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.0.2"])
      s.add_dependency(%q<rspec-legacy_formatters>.freeze, ["~> 1.0.0"])
      s.add_dependency(%q<guard>.freeze, ["~> 2.6.1"])
      s.add_dependency(%q<guard-rspec>.freeze, ["~> 4.3.1"])
      s.add_dependency(%q<coveralls>.freeze, ["~> 0.7.1"])
      s.add_dependency(%q<capybara>.freeze, ["~> 2.4.1"])
    end
  else
    s.add_dependency(%q<rails>.freeze, [">= 3.0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.0.2"])
    s.add_dependency(%q<rspec-legacy_formatters>.freeze, ["~> 1.0.0"])
    s.add_dependency(%q<guard>.freeze, ["~> 2.6.1"])
    s.add_dependency(%q<guard-rspec>.freeze, ["~> 4.3.1"])
    s.add_dependency(%q<coveralls>.freeze, ["~> 0.7.1"])
    s.add_dependency(%q<capybara>.freeze, ["~> 2.4.1"])
  end
end
