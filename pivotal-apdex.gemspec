# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{pivotal-apdex}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chad Woolley", "Brian Takita", "Pivotal Labs"]
  s.date = %q{2009-04-24}
  s.default_executable = %q{apdex_from_log}
  s.description = %q{Calculate apdex scores from an Apache or Nginx log}
  s.email = %q{pivotallabsopensource@googlegroups.com}
  s.executables = ["apdex_from_log"]
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "CHANGES.markdown",
    "README.markdown",
    "Rakefile",
    "VERSION.yml",
    "bin/apdex_from_log",
    "lib/apdex.rb",
    "lib/apdex/calculate_from_log.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/pivotal/apdex}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Calculate apdex scores from an Apache or Nginx log}
  s.test_files = [
    "spec/apdex/calculate_from_log_spec.rb",
    "spec/spec_suite.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
