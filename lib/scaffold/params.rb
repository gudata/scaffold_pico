module Scaffold
  class Params
    attr_reader :resource_name, # user for use in @user or filenames
     :resource_class_name, # CompanyOwnership
     :namespaces_array,
     :controller_file_name,
     :template,
     :css_framework,
     :views_folder_name,
     :route_resource_name,
     :services_folder

     def initialize choice
      (@modules, @model_name) = parse_model(choice[:model]) # what came from the params (it contain namespaces)

      @fields = expand_default_types(hasherize_fields(choice[:fields]))
      @index_fields = choice[:index_fields].blank? ? @fields.keys : choice[:index_fields]
      @search_fields = choice[:search_fields].blank? ? @fields.keys : choice[:search_fields]
      # permitted params
      @fields_permitted = associations_to_ids(@fields)
      @search_fields_permitted = search_fields_permitted(@search_fields, @fields)

      @joins = choice[:joins]
      @includes = choice[:includes]
      @template = choice[:template]
      @css_framework = choice[:css_framework]

      @resource_class_name = @model_name.singularize # CompanyOwnership
      # Admin::User or only User
      if @modules.empty?
        @modulized_resource_class_name = @resource_class_name
      else
        @modulized_resource_class_name =  "#{@modules.join('::')}::#{@resource_class_name}"
      end

      # routes
      @route_resource_name = @model_name.tableize # resourse :users
      @namespace = choice[:namespace] # for the controllers
      @base_controller = choice[:base_controller] || 'ApplicationController'
      @namespaces_array = parse_namespaces_array(@namespace)  # [:admin, ...?... ]

      # controller
      @resource_name = @model_name.tableize.singularize # user for use in @user or filenames
      @collection_name = @model_name.tableize # users for use in @users

      if @namespaces_array.blank?
        @controller_class_name = "#{@model_name.pluralize}Controller"
        @search_modulized_resource_class_name = "Search::#{@resource_class_name.pluralize}Search"

        # paths without namespace
        @new_resource_path = "[:new, :#{@resource_name}]"

        @resource_path = "[#{@resource_name}]"
        @edit_resource_path = "[:edit, #{@resource_name}]"

        @instance_resource_path = "[@#{@resource_name}]"
        @instance_edit_resource_path = "[:edit, @#{@resource_name}]"

        @collection_path = [@collection_name.to_sym]

      else
        @controller_namespaces = @namespace.camelize
        @controller_class_name = "#{@controller_namespaces}::#{@model_name.pluralize}Controller"
        @search_modulized_resource_class_name =  "Search::#{@controller_namespaces}::#{@resource_class_name.pluralize}Search"

        # paths with namespace
        @path_segments = @namespaces_array.map{|segment| segment.to_sym }
        @new_resource_path = "[:new, #{@path_segments.map{|item| ":#{item}"}.join(", ")}, :#{@resource_name}]"

        @resource_path = "[#{@path_segments.map{|item| ":#{item}"}.join(", ")}, #{@resource_name}]"
        @edit_resource_path = "[:edit, #{@path_segments.map{|item| ":#{item}"}.join(", ")}, #{@resource_name}]"

        @instance_resource_path = "[#{@path_segments.map{|item| ":#{item}"}.join(", ")}, @#{@resource_name}]"
        @instance_edit_resource_path = "[:edit, #{@path_segments.map{|item| ":#{item}"}.join(", ")}, @#{@resource_name}]"

        @collection_path = @path_segments.dup << @collection_name.to_sym

      end
      @controller_file_name = "#{@resource_class_name.tableize}_controller.rb"


      # view
      @views_folder_name = @model_name.tableize # users



      @services_folder = choice[:services_folder]
      debug_info if choice[:debug]
    end

    def debug_info
      puts "\n"
      puts "Debug:"
      puts "resource_class_name: #{@resource_class_name}, resource_name: #{@resource_name}, collection_name: #{@collection_name}"
      puts "modulized_resource_class_name: #{@modulized_resource_class_name}"

      puts "\ncontroller:"
      puts "class: #{@controller_class_name}"

      puts "\nroutes:"
      puts "route_resource_name: #{@route_resource_name}"
      puts "namespaces_array: #{@namespaces_array} (for urls helpers)"
      puts "resource_path: #{@resource_path}, resource_name: #{@collection_path}"
      puts "collection_path: #{@collection_path}"
      puts "\n\n"
    end

    def parse_model model
      chunks = model.split('::').select{|chunk| !chunk.empty?}
      class_name = chunks.pop
      [chunks, class_name]
    end

    def parse_namespaces_array namespace
      (namespace || "").split('/').collect{|name| name.underscore}
    end

    def hasherize_fields fields_array
      fields = {}
      fields_array.each do |field_string|
        (key, value) = field_string.split(':')
        fields[key] = value
      end
      fields
    end


    def expand_default_types hash
      hash.each_pair do |key, value|
        hash[key] = 'string' if value.blank?
      end
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

    # convert company => company_id
    def search_fields_permitted search_fields, fields
      to_ids = []
      search_fields.each do |key|
        next unless fields.keys.include?(key)
        type = fields[key]
        to_ids << (['references', 'belongs_to'].include?(type.downcase) ? "#{key}_id" : key)
      end
      to_ids
    end

  end
end