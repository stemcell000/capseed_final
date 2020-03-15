# -*- encoding: utf-8 -*-
# stub: puma 4.3.3 ruby lib
# stub: ext/puma_http11/extconf.rb

Gem::Specification.new do |s|
  s.name = "puma"
  s.version = "4.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/puma/puma/blob/master/History.md", "msys2_mingw_dependencies" => "openssl" } if s.respond_to? :metadata=
  s.require_paths = ["lib"]
  s.authors = ["Evan Phoenix"]
  s.date = "2020-02-28"
  s.description = "Puma is a simple, fast, threaded, and highly concurrent HTTP 1.1 server for Ruby/Rack applications. Puma is intended for use in both development and production environments. It's great for highly concurrent Ruby implementations such as Rubinius and JRuby as well as as providing process worker support to support CRuby well."
  s.email = ["evan@phx.io"]
  s.executables = ["puma", "pumactl"]
  s.extensions = ["ext/puma_http11/extconf.rb"]
  s.files = ["bin/puma", "bin/pumactl", "ext/puma_http11/extconf.rb"]
  s.homepage = "http://puma.io"
  s.licenses = ["BSD-3-Clause"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2")
  s.rubygems_version = "2.5.1"
  s.summary = "Puma is a simple, fast, threaded, and highly concurrent HTTP 1.1 server for Ruby/Rack applications"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nio4r>, ["~> 2.0"])
    else
      s.add_dependency(%q<nio4r>, ["~> 2.0"])
    end
  else
    s.add_dependency(%q<nio4r>, ["~> 2.0"])
  end
end
