# -*- encoding: utf-8 -*-
# stub: zebra-zpl 1.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "zebra-zpl".freeze
  s.version = "1.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Barnabas Bulpett".freeze, "Michael King".freeze, "Logan Green".freeze]
  s.date = "2019-12-19"
  s.description = "Print labels using ZPL2 and Ruby".freeze
  s.email = ["barnabasbulpett@gmail.com".freeze, "mtking1123@gmail.com".freeze, "loganagreen95@gmail.com".freeze]
  s.homepage = "https://github.com/bbulpett/zebra-zpl".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.6".freeze
  s.summary = "Simple DSL to create labels and send them to a Zebra printer using Ruby, ZPL2 and CUPS".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<img2zpl>.freeze, ["~> 1.0.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 13"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.9"])
      s.add_development_dependency(%q<guard>.freeze, ["~> 2.15"])
      s.add_development_dependency(%q<guard-rspec>.freeze, ["~> 4.7"])
    else
      s.add_dependency(%q<img2zpl>.freeze, ["~> 1.0.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 2.0"])
      s.add_dependency(%q<rake>.freeze, ["~> 13"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.9"])
      s.add_dependency(%q<guard>.freeze, ["~> 2.15"])
      s.add_dependency(%q<guard-rspec>.freeze, ["~> 4.7"])
    end
  else
    s.add_dependency(%q<img2zpl>.freeze, ["~> 1.0.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 13"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.9"])
    s.add_dependency(%q<guard>.freeze, ["~> 2.15"])
    s.add_dependency(%q<guard-rspec>.freeze, ["~> 4.7"])
  end
end
