# Copyright (c) 2010-2010 BJ Kim <burnssun@gmail.com>
# Distributed under the terms of the MIT license.
# See the LICENSE file which accompanies this software for the full text
#
desc "update version.rb"
task :reversion do
  File.open("lib/#{GEMSPEC.name}/version.rb", 'w+') do |file|
    file.puts("module #{PROJECT_MODULE}")
    file.puts('  VERSION = %p' % GEMSPEC.version.to_s)
    file.puts('end')
  end
end
