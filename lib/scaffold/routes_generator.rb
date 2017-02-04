module Scaffold
  class RoutesGenerator < Scaffold::BaseGenerator

    def generate
      puts "Insert something like this in routes.rb"
      nested_in_resources_count = @rails.route.nested_resources_as_array.count
      namespaces_count = @rails.controller.namespaces_as_path.count

      route_string = "#{spaces(nested_in_resources_count+namespaces_count+2)}resources :#{@rails.route.resource_name}"

      @rails.route.nested_resources_as_array.reverse.each_with_index do |resource_name, index|
        route_string = resources_block(resource_name, namespaces_count + nested_in_resources_count - index, route_string)
      end

      @rails.controller.namespaces_as_path.reverse.each_with_index do |namespace, index|
        index
        route_string = namespace_block(namespace, namespaces_count - index, route_string)
      end
      puts route_string
    end

    def spaces(count)
      " "*2*(count)
    end

    def resources_block resource_name, index, route_string
      ident = spaces(index+1)

      begin_resource_name_line = "#{ident}resources :#{resource_name.pluralize} do"
      end_resource_name_line = "#{ident}end"
      "#{begin_resource_name_line}\n#{route_string}\n#{end_resource_name_line}"
    end

    def namespace_block namespace, index, route_string
      ident = spaces(index+1)

      begin_namespace_line = "#{ident}namespace :#{namespace} do"
      end_namespace_line = "#{ident}end"
      "#{begin_namespace_line}\n#{route_string}\n#{end_namespace_line}"
    end

  end
end