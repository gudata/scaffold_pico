module Scaffold
  class FabricatorGenerator < Scaffold::BaseGenerator
    def generate
      fabricators_path = create_fabricators_path
      source_file_name = "fabrication.rb.erb"
      target_file_name = "#{@params.resource_name}_fabricator.rb"
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