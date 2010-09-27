# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{won}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["BJ Kim"]
  s.date = Time.now.strftime("%Y-%m-%d")
  s.description = %q{A code generation framework written in Ruby.}
  s.email = %q{burnssun@gmail.com}
  s.homepage = %q{http://github.com/burnssun/won}
  
  s.require_paths = ["lib"]
  s.summary = %q{A code generation framework written in Ruby.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

