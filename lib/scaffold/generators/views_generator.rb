module Scaffold
  module Generators
    class ViewsGenerator < Scaffold::Generators::BaseGenerator
      attr :css_framework, false
      attr :template, false

      def generate template, css_framework
        @css_framework = css_framework
        @template = template

        views_path = create_views_path
        templating_engine = choose_templating_engine

        # print "Creating view:"
        %w(index new edit show _form).each do |view_name|
          # print view_name, ' '
          create views_path, view_name, templating_engine, css_framework
        end
        # print "\n"
      end

      def create views_path, view_name, templating_engine, css_framework
        source_file_name = "#{view_name}.html.#{templating_engine.extension}.erb"
        target_file_name = "#{view_name}.html.#{templating_engine.extension}"
        source_file_path = find_root(templates, 'views',
          css_framework,
          templating_engine.source_folder_name,
          source_file_name)
        content = File.read(source_file_path)

        content = parse_template(content, {rails: @rails})


        target_file_path = File.join(create_views_path, target_file_name)
        write_with_confirmation(target_file_path, content)
      end

      def create_views_path
        views_path = File.join(Dir.pwd, 'app', 'views', @rails.controller.namespaces_as_path, @rails.view.folder_name)
        FileUtils.mkpath(views_path)
        views_path
      end


      def choose_templating_engine
        case template
        when 'slim'
          ::Scaffold::TemplateEngines::Slim.new
        else
          raise "I don't have defined templates for #{template}. However you can use [slim,]"
        end
      end


    end
  end
end