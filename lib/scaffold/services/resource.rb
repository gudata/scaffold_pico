module Scaffold
  module Services
    class Resource
      attr :resource

      def initialize rails
        @rails = rails
        @resource = Scaffold::Models::Resource.new(@rails.choice[:model])
      end

      def model_name
        @resource.model_name
      end

      def modules
        @resource.modules
      end

      def modules?
        @resource.modules?
      end

      def name
        @resource.name
      end

      def class_name
        @resource.class_name
      end

      def collection_name
        @resource.collection_name
      end

      def class_name_with_modules
        @resource.class_name_with_modules
      end

      def file_name
        "#{name}.rb"
      end

      # Search::Manage:BooksSearch
      def search_class_name
        if @rails.controller.namespaced?
          "Search::#{@rails.controller.namespaces_as_modules}::#{class_name.pluralize}Search"
        else
          "Search::#{class_name.pluralize}Search"
        end
      end

      def services_folder
        @rails.choice[:services_folder]
      end

      def fields
        expand_default_types(hasherize_fields(@rails.choice[:fields]))
      end

      private

      def expand_default_types hash
        hash.each_pair do |key, value|
          hash[key] = 'string' if value.blank?
        end
      end

      def hasherize_fields fields_array
        fields = {}
        fields_array.each do |field_string|
          (key, value) = field_string.split(':')
          fields[key] = value
        end
        fields
      end

    end
  end
end