module Scaffold
  class Main
    def initialize choice
      @choice = choice
      @rails = Rails.new(@choice)
    end

    def run
      Scaffold::FabricatorGenerator.new(@rails).generate if @choice[:fabrication]
      Scaffold::ControllerGenerator.new(@rails).generate
      Scaffold::ModelsGenerator.new(@rails).generate
      Scaffold::ViewsGenerator.new(@rails).generate(@choice[:template], @choice[:css_framework])
      Scaffold::RoutesGenerator.new(@rails).generate
    end

  end
end