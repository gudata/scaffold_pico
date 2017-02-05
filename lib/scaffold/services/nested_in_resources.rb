module Scaffold
  module Services
    class NestedInResources
      attr :resources

      def initialize rails
        @rails = rails

        @resources = nested_in_resources_as_array.collect do |raw_input|
          Scaffold::Models::Resource.new(raw_input)
        end
      end

      def nested?
        !resources.empty?
      end

      def each &block
        resources.each do |resource|
          yield resource
        end
      end

      def collect &block
        resources.collect do |resource|
          yield resource
        end
      end

      private

      def nested_in_resources_as_array
        (nested_in_resources || "").split('/')
      end

      def nested_in_resources
        @rails.choice[:nested_in_resources]
      end

    end
  end
end