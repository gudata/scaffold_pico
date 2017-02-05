module Scaffold
  module Generators
    class RoutesGenerator < Scaffold::Generators::BaseGenerator

      def generate
        puts "Insert something like this in routes.rb"

        nested_resources = @rails.nested_in_resources.resources
        nested_resources_count = nested_resources.count

        namespaces_count = @rails.controller.namespaces_as_path.count

        route_string = "#{spaces(nested_resources_count + namespaces_count + 2)}resources :#{@rails.route.resource_name}"

        nested_resources.reverse.each_with_index do |resource, index|
          route_string = resources_block(resource.name, namespaces_count + nested_resources_count - index, route_string)
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
end