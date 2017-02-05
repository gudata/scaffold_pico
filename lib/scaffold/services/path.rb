module Scaffold
  module Services
    class Path
      def initialize rails
        @rails = rails
      end

      def new_resource
        segments = [':new']
        segments += namespace_segments if @rails.controller.namespaced?
        segments += nested_resource_segments if @rails.route.nested?
        segments << ":#{@rails.resource.name}"
        "[#{segments.join(', ')}]"
      end

      def resource
        segments = []
        segments += namespace_segments if @rails.controller.namespaced?
        segments += nested_resource_segments if @rails.route.nested?
        segments << @rails.resource.name
        "[#{segments.join(', ')}]"
      end

      def edit_resource
        segments = [':edit']
        segments += namespace_segments if @rails.controller.namespaced?
        segments += nested_resource_segments if @rails.route.nested?
        segments << @rails.resource.name
        "[#{segments.join(', ')}]"
      end

      def instance_resource
        segments = []
        segments += namespace_segments if @rails.controller.namespaced?
        segments += nested_resource_segments if @rails.route.nested?
        segments << "@#{@rails.resource.name}"
        "[#{segments.join(', ')}]"
      end

      def edit_instance_resource
        segments = [':edit']
        segments += namespace_segments if @rails.controller.namespaced?
        segments += nested_resource_segments if @rails.route.nested?
        segments << "@#{@rails.resource.name}"
        "[#{segments.join(', ')}]"
      end

      def collection
        segments = []
        segments += namespace_segments if @rails.controller.namespaced?
        segments += nested_resource_segments if @rails.route.nested?
        segments << ":#{@rails.resource.collection_name}"
        "[#{segments.join(', ')}]"
      end

      private

      # [":admin", ":companies"]
      def namespace_segments
        @rails.controller.namespaces_as_path.map{|segment| ":#{segment}".to_sym }
      end

      # [client]
      def nested_resource_segments
        @rails.nested_in_resources.collect do |nested_resource|
          nested_resource.name
        end
      end

    end
  end
end