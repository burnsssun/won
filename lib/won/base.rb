
require 'tilt'
require 'fileutils'
require 'won/version'

module Won

  class Base

    def initialize
      @templates = {}
      @template_cache = Tilt::Cache.new
      @settings = { :render_option=>{}, :views=> "./won" }
    end

    private

    CALLERS_TO_IGNORE = [ # :nodoc:
                         /lib\/won.*\.rb$/, # all won code
                         /lib\/tilt.*\.rb$/, # all tilt code
                         /\(.*\)/, # generated code
                         /rubygems\/custom_require\.rb$/, # rubygems require hacks
                         /active_support/, # active_support require hacks
                         /bundler(\/runtime)?\.rb/, # bundler require hacks
                         /<internal:/ # internal in ruby >= 1.9.2
                        ]

    # add rubinius (and hopefully other VM impls) ignore patterns ...
    CALLERS_TO_IGNORE.concat(RUBY_IGNORE_CALLERS) if defined?(RUBY_IGNORE_CALLERS)

    # Like Kernel#caller but excluding certain magic entries and without
    # line / method information; the resulting array contains filenames only.
    def caller_files
      caller_locations.
        map { |file,line| file }
    end

    # Like caller_files, but containing Arrays rather than strings with the
    # first element being the file, and the second being the line.
    def caller_locations
      caller(1).
        map { |line| line.split(/:(?=\d|in )/)[0,2] }.
        reject { |file,line| CALLERS_TO_IGNORE.any? { |pattern| file =~ pattern } }
    end

    def render(engine, scope, data, locals={}, &block)
      begin
        template = compile_template(engine, data, @settings[:render_option], @settings[:views])
        template.render( scope || self, locals, &block)
      rescue NameError => e
        raise "#{e.name} not found"
      end
    end

    def compile_template(engine, data, options, views)
      
      @template_cache.fetch engine, data do
        template = Tilt[engine]
        raise "Template engine not found: #{engine}" if template.nil?

        case data
        when Symbol
          body, path, line = @templates[data]
          if body
            body = body.call if body.respond_to?(:call)
            template.new(path, line.to_i, options) { body }
          else
            found = false
            path = ::File.join(views, "#{data}.#{engine}")
            Tilt.mappings.each do |ext, klass|
              break if found = File.exists?(path)
              next unless klass == template
              path = ::File.join(views, "#{data}.#{ext}")
            end
            raise "Template file missing #{path}" if !found
            template.new(path, 1, options)
          end
        when Proc,String
          body = data.is_a?(String) ? Proc.new { data } : data
          path, line = self.class.caller_locations.first
          template.new(path, line.to_i, options, &body)
        else
          raise ArgumentError
        end

      end

    end

    public

    def str_obj(scope, data, locals={}, &block)
      render :str, scope, data, locals, &block
    end

    def str(data, locals={}, &block)
      render :str, self, data, locals, &block
    end

    def inline(file=nil)
      file = (file.nil? || file == true) ? (caller_files.first || File.expand_path($0)) : file 
     
      begin
        io = ::IO.respond_to?(:binread) ? ::IO.binread(file) : ::IO.read(file)
        app, data = io.gsub("\r\n", "\n").split(/^__END__$/, 2)
        data = app unless data
      rescue Errno::ENOENT
        raise "Template not found: #{file}"
      end

      lines = app ? app.count("\n") + 1 : 1
      template = nil
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

    def file(path, &block)
      fullpath = File.expand_path(path) 
      out = yield
      mkdir_p File.dirname( fullpath )
      File.new( fullpath, "w" ).write( out )
    end
    
  end

  class Application < Base
    def initialize
      super
    end
  end

  class << self
    def application
      @application ||= Application.new
    end
  end

  module Delegator
    def self.delegate(*methods)
      methods.each do |method_name|
        eval <<-RUBY, binding, '(__DELEGATE__)', 1
          def #{method_name}(*args, &b)
            ::Won::application.#{method_name}(*args, &b)
          end
          RUBY
      end
    end

   delegate :str, :str_obj, :erb, :inline, :file

  end

end

