module Scaffold
  class Main
    def initialize choice
      @choice = choice
      @rails = Rails.new(@choice)
    end

    def run
      Scaffold::Generators::FabricatorGenerator.new(@rails).generate if @choice[:fabrication]
      Scaffold::Generators::ControllerGenerator.new(@rails).generate
      Scaffold::Generators::ModelsGenerator.new(@rails).generate
      Scaffold::Generators::ViewsGenerator.new(@rails).generate(@choice[:template], @choice[:css_framework])
      Scaffold::Generators::RoutesGenerator.new(@rails).generate
    end

  end
end