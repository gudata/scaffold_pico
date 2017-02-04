module Scaffold
  class ModelsGenerator < Scaffold::BaseGenerator
    def generate
      searches_path = create_searches_path
      puts "Add '#{@rails.resource.services_folder}' folder in your autoload_paths (application.rb)"
      create_search_object searches_path
      create_model
    end

    def create_model
      source_file_name = "model.rb.erb"
      target_file_name = @rails.resource.file_name

      source_file_path = find_root(templates, source_file_name)
      content = File.read(source_file_path)

      content = parse_template(content, {rails: @rails})

      if @rails.resource.modules?
        model_path = File.join(Dir.pwd, 'app', 'models')
      else
        model_path = File.join(Dir.pwd, 'app', 'models', @rails.resource.modules.map(&:underscore))
        FileUtils.mkdir_p model_path
      end

      target_file_path = File.join(model_path, target_file_name)

      write_with_confirmation(target_file_path, content)
    end

    def create_search_object searches_path
      source_file_name = "search.rb.erb"
      target_file_name = "#{@rails.resource.name.pluralize}_search.rb"

      source_file_path = find_root(templates, source_file_name)
      content = File.read(source_file_path)

      content = parse_template(content, {rails: @rails})

      target_file_path = File.join(searches_path, target_file_name)
      write_with_confirmation(target_file_path, content)
    end

    def create_searches_path
      searches_path = File.join(Dir.pwd, 'app', @rails.resource.services_folder, 'search', @rails.controller.namespaces_as_path)
      FileUtils.mkpath(searches_path)
      searches_path
    end

  end
end