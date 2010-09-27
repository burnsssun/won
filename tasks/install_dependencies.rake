# Copyright (c) 2010-2010 BJ Kim <burnssun@gmail.com>
# Distributed under the terms of the MIT license.
# See the LICENSE file which accompanies this software for the full text
#
desc 'install dependencies'
task :install_dependencies => [:gem_installer] do
  GemInstaller.new do
    setup_gemspec(GEMSPEC)
  end
end
