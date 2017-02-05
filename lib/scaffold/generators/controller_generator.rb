module Scaffold
  module Generators
    class ControllerGenerator < Scaffold::Generators::BaseGenerator

      def generate
        controller_file_path = create_path(@rails.controller.file_name)

        # puts "Creating #{controller_file_path}"

        filepath = find_root(templates, 'controller.rb.erb')
        content = File.read(filepath)

        content = parse_template(content, {rails: @rails})

        # puts content
        write_with_confirmation(controller_file_path, content)
      end

      def create_path file_name
        controller_path = File.join(Dir.pwd, 'app', 'controllers', @rails.controller.namespaces_as_path)
        controller_file_path = File.join(controller_path, file_name)
        FileUtils.mkpath(controller_path)
        controller_file_path
      end
    end
  end
end
