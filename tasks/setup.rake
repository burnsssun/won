# Copyright (c) 2010-2010 BJ Kim <burnssun@gmail.com>
# Distributed under the terms of the MIT license.
# See the LICENSE file which accompanies this software for the full text
#
desc 'install all possible dependencies'
task :setup => :gem_installer do
  GemInstaller.new do
    # core

    # spec
    gem 'bacon'
    gem 'rcov'

    # doc
    gem 'yard'

    setup
  end
end
