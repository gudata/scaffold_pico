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

    def project_root
      Dir.pwd
    end

    # Check to see if it is overridden and use it
    def find_root *segments
      original = File.join(root, segments)
      overridden = File.join(project_root, segments)
      File.exists?(overridden) ? overridden : original
    end

    # the root of the templates
    def templates
      'lib/templates/pico/'
    end
  end
end