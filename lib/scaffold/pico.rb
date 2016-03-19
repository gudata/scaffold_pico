module Scaffold
  class Pico
    def initialize choice
      @model_name = Choice[:model]
      @namespace = Choice[:namespace]
      @fields = Choice[:fields]
      @joins = Choice[:joins]
      @includes = Choice[:includes]

      # http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html
      @resource_class_name = @model_name.camelize.singularize # CompanyOwnerships
      @resource_name = @model_name.singularize.dasherize # @user
      @collection_name = @model_name.pluralize.dasherize # @user

      # Admin::User or only User
      if @namespace.present?
        @namespaced_resource_class_name =  "#{@namespace}::#{@resource_class_name}"
      else
        @namespaced_resource_class_name = @resource_class_name
      end

      # [:admin, ...?... ]
      @namespaces_path = @namespace.split('::').collect{|name| name.underscore}

      path_segments = @namespaces_path.map{|segment| segment.to_sym }
      @resource_path = "#{[path_segments, @resource_name].flatten}"
      @collection_path = "#{[path_segments, :index].flatten}"

      @controller_class_name = "#{@namespace}::#{@resource_class_name}Controller"
      @controller_file_name = "#{@resource_class_name.tableize}_controller.rb"

    end

    def run
      generate_controller
    end

    private
    def generate_controller
      filename = File.join(root, templates, 'controller.rb')
      content = File.read(filename)
      # http://www.stuartellis.eu/articles/erb/
      content = ::ERB.new(content).result binding
      # puts content
      IO.write(create_path, content)
    end

    def create_path
      controller_path = File.join(Dir.pwd, 'app', 'controllers', @namespaces_path)
      controller_file_path = File.join(controller_path, @controller_file_name)
      FileUtils.mkpath(controller_path)
      controller_file_path
    end

    def params
      OpenStruct.new(vars).instance_eval { binding }
    end

    def root
      '.'
    end

    def templates
      'lib/templates/pico/'
    end
  end
end