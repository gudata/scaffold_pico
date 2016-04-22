module Scaffold
  class RoutesGenerator < Scaffold::BaseGenerator

    def generate
      puts "Insert something like this in routes.rb"
      namespaces_count = @params.namespaces_array.count
      route_string = "#{spaces(namespaces_count+2)}resources :#{@params.route_resource_name}"

      @params.namespaces_array.reverse.each_with_index do |namespace, index|
        route_string = namespace_block(namespace, namespaces_count - index, route_string)
      end
      puts route_string
    end

    def spaces(count)
      " "*2*(count)
    end

    def namespace_block namespace, index, route_string
      ident = spaces(index+1)

      begin_namespace_line = "#{ident}namespace :#{namespace} do"
      namespace = "#{ident*2}#{namespace}"
      end_namespace_line = "#{ident}end"
      "#{begin_namespace_line}\n#{route_string}\n#{end_namespace_line}"
    end

  end
end