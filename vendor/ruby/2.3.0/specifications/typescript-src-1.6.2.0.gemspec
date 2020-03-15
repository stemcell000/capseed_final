# -*- encoding: utf-8 -*-
# stub: typescript-src 1.6.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "typescript-src".freeze
  s.version = "1.6.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = [["lib".freeze]]
  s.authors = ["KAWACHI Takashi".freeze]
  s.date = "2015-09-30"
  s.description = "TypeScript source files".freeze
  s.email = ["tkawachi@gmail.com".freeze]
  s.homepage = "https://github.com/typescript-ruby/typescript-src-ruby".freeze
  s.licenses = ["Apache 2.0 License".freeze]
  s.rubygems_version = "3.0.6".freeze
  s.summary = "TypeScript source files".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
