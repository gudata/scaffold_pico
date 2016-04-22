module Scaffold
  class Main
    def initialize choice
      @params = Params.new(choice)
    end

    def run
      Scaffold::ControllerGenerator.new(@params).generate
      Scaffold::ModelsGenerator.new(@params).generate
      Scaffold::ViewsGenerator.new(@params).generate
      Scaffold::RoutesGenerator.new(@params).generate
    end

  end
end