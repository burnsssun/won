require 'fileutils'

module Won

  module Helper
  
    def file *args
      engine = :str
      template = nil
      path = nil
      if args.first.is_a?( Symbol )
        engine = args.first
        path, template = args[1],args[2]
      else
        engine = :str
        path, template = args[0],args[1]
      end
      
      out = nil
      if template
        out = send engine, template
      else
        if block_given?
          out = yield 
        else # file :erb, './base/version.rb'
          out = send engine, path.to_sym
        end
      end
      raise "can not render: template missing? " unless out
      fullpath = File.expand_path(path) 
      ::FileUtils.mkdir_p File.dirname( fullpath )
      File.open( fullpath, "w" ) { |f| f.write( out ) }
    end

  end

end

