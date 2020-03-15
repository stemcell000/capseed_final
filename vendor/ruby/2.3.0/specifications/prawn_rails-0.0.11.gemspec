# -*- encoding: utf-8 -*-
# stub: prawn_rails 0.0.11 ruby lib

Gem::Specification.new do |s|
  s.name = "prawn_rails".freeze
  s.version = "0.0.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Walton Hoops".freeze]
  s.date = "2012-08-28"
  s.description = "The prawn_rails gem provides a Prawn based view engine for creating PDFs with rails.".freeze
  s.email = "me@waltonhoops.com".freeze
  s.extra_rdoc_files = ["README.rdoc".freeze]
  s.files = ["README.rdoc".freeze]
  s.homepage = "http://github.com/Whoops/prawn-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.6".freeze
  s.summary = "Integrates Prawn into Rails in a natural way".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3.0.0"])
      s.add_runtime_dependency(%q<prawn>.freeze, [">= 0.11.1"])
    else
      s.add_dependency(%q<railties>.freeze, [">= 3.0.0"])
      s.add_dependency(%q<prawn>.freeze, [">= 0.11.1"])
    end
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.0.0"])
    s.add_dependency(%q<prawn>.freeze, [">= 0.11.1"])
  end
end
