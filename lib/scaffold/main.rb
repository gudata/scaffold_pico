module Scaffold
  class Main
    def initialize choice
      @choice = choice
      @params = Params.new(@choice)
    end

    def run
      Scaffold::FabricatorGenerator.new(@params).generate if @choice[:fabrication]
      Scaffold::ControllerGenerator.new(@params).generate
      Scaffold::ModelsGenerator.new(@params).generate
      Scaffold::ViewsGenerator.new(@params).generate
      Scaffold::RoutesGenerator.new(@params).generate
    end

  end
end