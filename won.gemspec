# -*- encoding: utf-8; mode: Ruby; -*-

require "date"

Gem::Specification.new do |s|
  s.name = "won"
  s.version = IO.read( "lib/won/version.rb" )[ /VERSION = '(.*)'/ ] && $1
  s.date = Date.today.to_s
  s.authors = ["BJ Kim"]
  s.email = ["burnssun@gmail.com"]
  s.summary = %q{Won is a source code generation framework. }
  s.description = %q{Won is a source code generation framework. inspired by sinatra.}
  s.homepage = %q{http://github.com/burnssun/won}
  s.extra_rdoc_files = ["README.md"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = s.name

  s.files = `git ls-files -- lib/* bin/* won/* LICENSE README.md`.split("\n")
  s.default_executable = 'won'
  s.executables = ['won']
  s.require_paths = ["lib"]

  s.add_development_dependency(%q<rake>, [">= 0.8.7"])
  s.add_development_dependency(%q<minitest>, [">= 0"])
  s.add_development_dependency(%q<rcov>, [">= 0"])
  s.add_development_dependency(%q<yard>, [">= 0"])
end
