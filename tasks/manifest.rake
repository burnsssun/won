# Copyright (c) 2010-2010 BJ Kim <burnssun@gmail.com>
# Distributed under the terms of the MIT license.
# See the LICENSE file which accompanies this software for the full text
#
desc 'update manifest'
task :manifest do
  File.open('MANIFEST', 'w+'){|io| io.puts(*GEMSPEC.files) }
end
