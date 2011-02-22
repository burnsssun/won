require 'fileutils'

module Won

  module Helper
  
    def _file mode, *args
      engine = :str
      template = nil
      path = nil
      if args.first.is_a?( Symbol ) # file :mu, "Rakefile", :rake
        engine = args.first
        path, template = args[1],args[2]
      else # file "hello.c", :hello
        engine = :str
        path, template = args[0],args[1]
      end
      
      out = nil
      if template
        out = send engine, template
      else
        if block_given?
          out = yield 
        else # file :mu, './base/version.rb'
          out = send engine, path.to_sym
        end
      end
      raise "can not render: template missing? " unless out
      fullpath = File.expand_path(path) 
      File.rename fullpath, fullpath + '.bak' if File.exist?( fullpath )
      ::FileUtils.mkdir_p File.dirname( fullpath )
      File.open( fullpath, mode ) { |f| f.write( out ) }
    end

    def file *args, &blk
      _file 'w', *args, &blk
    end

    def append *args, &blk
      _file 'a', *args, &blk
    end

  end

end

