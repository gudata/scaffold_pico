require 'readline'

module Scaffold
  class BaseGenerator
    @@aways_ovewrite = false

    def initialize params
      @params = params
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

      answer = if @@aways_ovewrite
        puts "#{target_file_path} exists, overwrite? [yaN] y"
        'y'
      else
         ask("#{target_file_path} exists, overwrite? [yaN]").downcase
      end

      @@aways_ovewrite = true if answer == 'a'

      IO.write(target_file_path, content) if answer == 'y'
    end

  end
end