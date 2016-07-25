module Scaffold
  class FabricatorGenerator < Scaffold::BaseGenerator
    def generate
      fabricator_name = @params.resource_class_name.underscore
      create fabricator_name
    end

    def create fabricator_name
      fabricators_path = create_fabricators_path
      source_file_name = "#{fabricator_name}.rb.erb"
      target_file_name = "#{fabricator_name}_fabricator.rb"
      source_file_path = File.join(root, templates, 'fabricators', source_file_name)
      content = File.read(source_file_path)

      # http://www.stuartellis.eu/articles/erb/
      content = ::ERB.new(content, nil, '-').result(@params.instance_eval{ binding })#.gsub(/\s+\n$/, "")

      target_file_path = File.join(fabricators_path, target_file_name)
      IO.write(target_file_path, content)
    end

    def create_fabricators_path
      fabricators_path = File.join(Dir.pwd, 'spec', 'fabricators')
      FileUtils.mkpath(fabricators_path)
      fabricators_path
    end

  end
end