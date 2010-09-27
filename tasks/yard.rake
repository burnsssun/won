# Copyright (c) 2010-2010 BJ Kim <burnssun@gmail.com>
# Distributed under the terms of the MIT license.
# See the LICENSE file which accompanies this software for the full text
#
desc 'Generate YARD documentation'
task :yard => :clean do
  sh("yardoc -o ydoc --protected -r #{PROJECT_README} lib/**/*.rb tasks/*.rake")
end
