# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + "/lib/won/version"
require "date"

Gem::Specification.new do |s|
  s.name = "won"
  s.version = Won::VERSION
  s.date = Date.today.to_s
  s.authors = ["Andrew Stone", "Fred Wu", "Daniel Mendler"]
  s.email = ["andy@stonean.com", "ifredwu@gmail.com", "mail@daniel-mendler.de"]
  s.summary = %q{Won is a template language.}
  s.description = %q{Won is a source code generation framework. inspired by sinatra}
  s.homepage = %q{http://github.com/burnssun/won}
  s.extra_rdoc_files = ["README.md"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = s.name

  s.files = `git ls-files -- lib/* bin/* README.md`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency(%q<tilt>, ["~> 1.1"])

  s.add_development_dependency(%q<rake>, [">= 0.8.7"])
  s.add_development_dependency(%q<haml>, [">= 0"])
  s.add_development_dependency(%q<minitest>, [">= 0"])
  s.add_development_dependency(%q<rcov>, [">= 0"])
  s.add_development_dependency(%q<yard>, [">= 0"])
end
