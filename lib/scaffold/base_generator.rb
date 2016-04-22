module Scaffold
  class BaseGenerator

    def initialize params
      @params = params
    end

    def objectify
      OpenStruct.new(vars).instance_eval { binding }
    end

    # where is the root of the gem
    def root
      Scaffold.root
    end

    # the root of the templates
    def templates
      'lib/templates/pico/'
    end
  end
end