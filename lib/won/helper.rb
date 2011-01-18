require 'fileutils'

module Won

  module Helper
  
    def file path
      fullpath = File.expand_path(path) 
      out = yield if block_given?
      ::FileUtils.mkdir_p File.dirname( fullpath )
      File.open( fullpath, "w" ) { |f| f.write( out ) }
    end

  end

end

