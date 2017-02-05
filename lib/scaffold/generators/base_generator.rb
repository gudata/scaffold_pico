require 'readline'

module Scaffold
  module Generators
    class BaseGenerator
      @@aways_ovewrite = false

      def initialize rails
        @rails = rails
      end

      def objectify
        OpenStruct.new(vars).instance_eval { binding }
      end

      # where is the root of the gem
      def root
        Scaffold.root
      end

      def project_root
        Dir.pwd
      end

      # Check to see if it is overridden and use it
      def find_root *segments
        original = File.join(root, segments)
        overridden = File.join(project_root, segments)
        File.exists?(overridden) ? overridden : original
      end

      # the root of the templates
      def templates
        'lib/templates/pico/'
      end

      def ask(prompt="", newline=false)
        prompt += "\n" if newline
        Readline.readline(prompt, true).squeeze(" ").strip
      end

      def write_with_confirmation(target_file_path, content)
        unless File.exists?(target_file_path)
          IO.write(target_file_path, content)
          return
        end

        @@aways_ovewrite = 'a' if @rails.choice[:force].present?

        answer = if @@aways_ovewrite
          if @rails.choice[:force].blank?
            puts "#{target_file_path} exists, overwrite? [yaN] y"
          end
          'y'
        else
           ask("#{target_file_path} exists, overwrite? [yaN]").downcase
        end

        @@aways_ovewrite = true if answer == 'a'

        IO.write(target_file_path, content) if answer == 'y'
      end

      def parse_template(content, context_hash)
        # http://www.stuartellis.eu/articles/erb/
        # content = ::ERB.new(content, nil, '-').result(@params.instance_eval{ binding })#.gsub(/\s+\n$/, "")

        # content = ::ERB.new(content, 0, '>').result(ErbContext.new(context_hash).get_binding)
        content = ::ERB.new(content, 0, '-').result(ErbContext.new(context_hash).get_binding)
      end

    end
  end
end