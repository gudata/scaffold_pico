module Scaffold
  class ModelsGenerator < Scaffold::BaseGenerator
    def generate
      searches_path = create_searches_path
      puts "Don't forget to add '#{@params.services_folder}' in your autoload_paths (application.rb)"
      create_search_object searches_path
    end

    def create_search_object searches_path
      source_file_name = "search.rb.erb"
      target_file_name = "#{@params.resource_name.pluralize}_search.rb"

      source_file_path = File.join(root, templates, source_file_name)
      content = File.read(source_file_path)

      content = ::ERB.new(content, nil, '-').result(@params.instance_eval{ binding })

      target_file_path = File.join(searches_path, target_file_name)
      IO.write(target_file_path, content)
    end

    def create_searches_path
      searches_path = File.join(Dir.pwd, 'app', @params.services_folder, 'search', @params.namespaces_array)
      FileUtils.mkpath(searches_path)
      searches_path
    end


  end
end