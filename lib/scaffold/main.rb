require_relative 'generators/base_generator'
require_relative 'generators/controller_generator'
require_relative 'generators/models_generator'
require_relative 'generators/views_generator'
require_relative 'generators/routes_generator'
require_relative 'generators/fabricator_generator'
require_relative 'generators/locales_generator'

module Scaffold
  class Main
    def initialize choice
      @choice = choice
      @rails = Rails.new(@choice)
    end

    def run
      Scaffold::Generators::FabricatorGenerator.new(@rails).generate if @choice[:fabrication]
      Scaffold::Generators::ControllerGenerator.new(@rails).generate
      if @choice[:no_model]
        puts("Skipping generating the model...")
      else
        Scaffold::Generators::ModelsGenerator.new(@rails).generate
      end
      Scaffold::Generators::ViewsGenerator.new(@rails).generate(@choice[:template], @choice[:css_framework])
      Scaffold::Generators::RoutesGenerator.new(@rails).generate
      Scaffold::Generators::LocalesGenerator.new(@rails).generate
    end

  end
end
