
@project = ARGV[0] || "mygem"

mkdir_p @project

cd @project

file :mu, 'Rakefile'

file :mu, "#@project.gemspec", :gemspec

file :mu, "./lib/#@project.rb", :libprj

file :mu, "./lib/#@project/version.rb", :version

file 'LICENSE'



__END__

@@ Rakefile

begin; require 'rubygems'; rescue LoadError; end

require 'rake'
require 'rake/clean'
require 'time'
require 'date'

task :default => [:gem]

task :up do
  ver_file = "lib/{{ @project }}/version.rb"
  orig = IO.read( ver_file  )
  if orig[ /VERSION = '(.*)'/ ] && $1
    new_ver = $1.succ
    File.open( ver_file, "w") { |f| f.write(orig.gsub( $1, new_ver)) }
    puts "version up to #{new_ver}"
  end
end

task :gem do
  sh "gem build {{ @project }}.gemspec"
end

CLEAN.include %w[
  **/.*.sw?
  *.gem
  .config
  **/*~
  **/*.tmp
  **/{data.db,cache.yaml}
  *.yaml
  pkg
  rdoc
  ydoc
  .#*
  .yardoc
  *coverage*
]

@@ gemspec
require "date"

Gem::Specification.new do |s|
  s.name = '{{ @project }}'
  s.version = IO.read( "lib/{{ @project }}/version.rb" )[ /VERSION = '(.*)'/ ] && $1
  s.date = Date.today.to_s
  s.authors = [`git config --global --get user.name`]
  s.email = [`git config --global --get user.email`]
  s.summary = %q{}
  s.description = %q{}
  s.homepage = %q{http://github.com/}
  s.extra_rdoc_files = ["README.md"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = s.name

  s.files = `git ls-files -- lib/* bin/* LICENSE README.md`.split("\n")
  #s.default_executable = '{{ @project }}'
  #s.executables = ['{{ @project }}']
  s.require_paths = ["lib"]

  s.add_development_dependency(%q<rake>, [">= 0.8.7"])
  s.add_development_dependency(%q<minitest>, [">= 0"])
  s.add_development_dependency(%q<rcov>, [">= 0"])
  s.add_development_dependency(%q<yard>, [">= 0"])
end



@@ libprj

libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require '{{ @project }}/version'

@@ version
module {{ @project.capitalize }}

  VERSION = '0.0.0'

end


@@ LICENSE

# Copyright (c) 2010-2010 #{`git config --global --get user.name`.chomp} <#{`git config --global --get user.email`.chomp}>
# Distributed under the terms of the MIT license.
# See the LICENSE file which accompanies this software for the full text
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
