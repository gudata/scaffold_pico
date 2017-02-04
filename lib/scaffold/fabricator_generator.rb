module Scaffold
  class FabricatorGenerator < Scaffold::BaseGenerator
    def generate
      fabricators_path = create_fabricators_path
      source_file_name = "fabrication.rb.erb"
      target_file_name = "#{@rails.resource.name}_fabricator.rb"
      source_file_path = find_root(templates, 'fabricators', source_file_name)
      content = File.read(source_file_path)

      content = parse_template(content, {rails: @rails})

      target_file_path = File.join(fabricators_path, target_file_name)

      write_with_confirmation(target_file_path, content)
    end

    def create_fabricators_path
      fabricators_path = File.join(Dir.pwd, 'spec', 'fabricators')
      FileUtils.mkpath(fabricators_path)
      fabricators_path
    end

  end
end