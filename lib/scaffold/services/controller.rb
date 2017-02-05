module Scaffold
  module Services
    class Controller
      def initialize rails
        @rails = rails
      end

      # example: Manage::BooksController
      def class_name
        if @rails.controller.namespaced?
          "#{namespaces_as_modules}::#{@rails.resource.class_name.pluralize}Controller"
        else
          "#{@rails.resource.class_name.pluralize}Controller"
        end
      end

      def file_name
        "#{@rails.resource.class_name.tableize}_controller.rb"
      end

      def base_controller
        @rails.choice[:base_controller] || 'ApplicationController'
      end

      # very bad idea to go so deep
      def index_joins
        @rails.choice[:joins]
      end

      def index_includes
        @rails.choice[:includes]
      end

      def namespaced?
        namespaces_as_string.present?
      end

      # Admin::ClassRooms::Etc
      def namespaces_as_modules
        namespaces_as_path.join.camelize
      end

      # ['admin', 'classrooms' ]
      def namespaces_as_path
        (namespaces_as_string || "").split('/').collect{|name| name.underscore}
      end


      # which fields will be visible on the index page
      def index_fields
        @rails.choice[:index_fields].blank? ? @rails.resource.fields.keys : @rails.choice[:index_fields]
      end

      def search_fields
        @rails.choice[:search_fields].blank? ? @rails.resource.fields.keys : @rails.choice[:search_fields]
      end

      # convert company => company_id
      # Used in the #index action
      def permitted_search_fields
        fields = @rails.resource.fields

        to_ids = []

        expanded_fields = expand_association_to_ids fields

        search_fields.each do |key|
          next unless expanded_fields.keys.include?(key)
          type = expanded_fields[key]
          to_ids << (['references', 'belongs_to'].include?(type.downcase) ? "#{key}_id" : key)
        end
        to_ids
      end

      def permitted_fields
        associations_to_ids(@rails.resource.fields)
      end


      private

      # admin/classrooms/etc
      def namespaces_as_string
        @namespaces_as_path ||= @rails.choice[:controller_namespaces]
      end


      # if the field is belongs_to
      # make so that fields contains the `field` and field_id
      def expand_association_to_ids fields
        expanded = {}
        fields.each_pair do |name, type|
          case type
          when 'belongs_to'
            expanded["#{name}_id"] = 'integer'
          end
        end
        fields.merge(expanded)
      end

      # convert company => company_id
      def associations_to_ids hash
        to_ids = {}
        hash.each_pair do |key, type|
          key_name = ['references', 'belongs_to'].include?(type.downcase) ? "#{key}_id" : key
          to_ids[key_name] = type
        end
        to_ids
      end
    end
  end
end