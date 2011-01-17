module Won
  
  module Simple
    
    CALLERS_TO_IGNORE = [ # :nodoc:
                         /lib\/won.*\.rb$/, # all won code
                         /\(.*\)/, # generated code
                         /rubygems\/custom_require\.rb$/, # rubygems require hacks
                         /active_support/, # active_support require hacks
                         /bundler(\/runtime)?\.rb/, # bundler require hacks
                         /<internal:/ # internal in ruby >= 1.9.2
                        ]

    CALLERS_TO_IGNORE.concat(RUBY_IGNORE_CALLERS) if defined?(RUBY_IGNORE_CALLERS)

    def caller_files
      caller_locations.map { |file,line| file }
    end

    def caller_locations
      caller(1).
        map { |line| line.split(/:(?=\d|in )/)[0,2] }.
        reject { |file,line| CALLERS_TO_IGNORE.any? { |pattern| file =~ pattern } }
    end

    def inline(file=nil)
      file = (file.nil? || file == true) ? (File.expand_path($0)) : file
      
      begin
        io = ::IO.respond_to?(:binread) ? ::IO.binread(file) : ::IO.read(file)
        app, data = io.gsub("\r\n", "\n").split(/^__END__$/, 2)
        data = app unless data
      rescue Errno::ENOENT
        raise "Template not found: #{file}"
      end

      lines = app ? app.count("\n") + 1 : 1
      template = nil

      @templates ||= {}
      @views ||= './won'

      data.each_line do |line|
        lines += 1
        if line =~ /^@@\s*(.*\S)\s*$/
          template = ''
          @templates[$1.to_sym] = [template, file, lines]
        elsif template
          template << line
        end
      end
    end

    def str data, scope = nil
      case data
      when Symbol
        body, path, line = @templates[data]
        if body
          body = body.call if body.respond_to?(:call)
        else
          path = ::File.join( @views, "#{data}.str")
          begin
            body = IO.read( path )
            @templates[data] = [body,path,1]
          rescue
            raise "Template file missing #{path}" 
          end
        end
      when Proc,String
        body = data.is_a?(String) ? Proc.new { data } : data
        path, line = self.class.caller_locations.first
      else
        raise ArgumentError
      end
      
      unless scope
        TOPLEVEL_BINDING.eval "%Q{#{body}}", path, line
      else
        scope.instance_eval "%Q{#{body}}", path, line
      end
      
    end

  end
  
end

include Won::Simple

inline true


