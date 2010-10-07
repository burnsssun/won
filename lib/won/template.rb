
require 'digest/sha1'

module Won

  class Template

    def initialize(template, options = {})
      @template, @options = template, options
      compile
    end

    def compile
      temp = @template.dup
      start_heredoc = "T" << Digest::SHA1.hexdigest(temp)
      start_heredoc, end_heredoc = "\n<<#{start_heredoc}\n", "\n#{start_heredoc}\n"
      bufadd = "_out_ << "

      temp.gsub!(/\%\%\s+(.*?)\s+\?\%\%/m,
            "#{end_heredoc} \\1; #{bufadd} #{start_heredoc}")

      @compiled = "_out_ = ''
#{bufadd} #{start_heredoc} #{temp} #{end_heredoc}
_out_"
    end

    def result(binding)
      eval(@compiled, binding, @options[:file]).strip
    end
  end

end

