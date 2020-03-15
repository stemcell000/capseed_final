# -*- encoding: utf-8 -*-
# stub: derailed_benchmarks 0.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "derailed_benchmarks".freeze
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Richard Schneeman".freeze]
  s.date = "2014-10-15"
  s.description = " Go faster, off the Rails ".freeze
  s.email = ["richard.schneeman+rubygems@gmail.com".freeze]
  s.homepage = "https://github.com/schneems/derailed_benchmarks".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.6".freeze
  s.summary = "Benchmarks designed to performance test your ENTIRE site".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<memory_profiler>.freeze, ["~> 0"])
      s.add_runtime_dependency(%q<get_process_mem>.freeze, ["~> 0"])
      s.add_runtime_dependency(%q<benchmark-ips>.freeze, ["~> 2"])
    else
      s.add_dependency(%q<memory_profiler>.freeze, ["~> 0"])
      s.add_dependency(%q<get_process_mem>.freeze, ["~> 0"])
      s.add_dependency(%q<benchmark-ips>.freeze, ["~> 2"])
    end
  else
    s.add_dependency(%q<memory_profiler>.freeze, ["~> 0"])
    s.add_dependency(%q<get_process_mem>.freeze, ["~> 0"])
    s.add_dependency(%q<benchmark-ips>.freeze, ["~> 2"])
  end
end
