module Scaffold
  class Params
    attr_reader :resource_name, :namespaces_array, :controller_file_name, :template, :css_framework, :views_folder_name, :route_resource_name, :services_folder

    def expand_default_types hash
      hash.each_pair do |key, value|
        hash[key] = 'string' if value.blank?
      end
    end

    def initialize choice
      (@modules, @model_name) = parse_model(choice[:model]) # what came from the params (it contain namespaces)

      @fields = expand_default_types(hasherize_fields(choice[:fields]))
      @index_fields = choice[:index_fields].blank? ? @fields.keys : choice[:index_fields]
      @search_fields = choice[:search_fields].blank? ? @fields.keys : choice[:search_fields]

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
      @route_resource_name = @model_name.tableize # resoures :users
      @namespace = choice[:namespace] # for the controllers
      @base_controller = choice[:base_controller] || 'ApplicationController'
      @namespaces_array = parse_namespaces_array(@namespace)  # [:admin, ...?... ]

      # controller
      if @namespaces_array.blank?
        @controller_class_name = "#{@model_name.pluralize}Controller"
        @search_modulized_resource_class_name = "Search::#{@resource_class_name}Search"
      else
        @controller_namespaces = @namespace.camelize
        @controller_class_name = "#{@controller_namespaces}::#{@model_name.pluralize}Controller"
        @search_modulized_resource_class_name =  "Search::#{@controller_namespaces}::#{@resource_class_name.pluralize}Search"
      end
      @controller_file_name = "#{@resource_class_name.tableize}_controller.rb"

      @resource_name = @model_name.tableize.singularize # user for use in @user or filenames
      @collection_name = @model_name.tableize # users for use in @users

      # view
      @views_folder_name = @model_name.tableize # users

      @path_segments = @namespaces_array.map{|segment| segment.to_sym }
      @new_resource_path = "[:new, #{@path_segments.map{|item| ":#{item}"}.join(", ")}, :#{@resource_name}]"

      @resource_path = "[#{@path_segments.map{|item| ":#{item}"}.join(", ")}, #{@resource_name}]"
      @edit_resource_path = "[:edit, #{@path_segments.map{|item| ":#{item}"}.join(", ")}, #{@resource_name}]"

      @instance_resource_path = "[#{@path_segments.map{|item| ":#{item}"}.join(", ")}, @#{@resource_name}]"
      @instance_edit_resource_path = "[:edit, #{@path_segments.map{|item| ":#{item}"}.join(", ")}, @#{@resource_name}]"

      @collection_path = @path_segments.dup << @collection_name.to_sym

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

  end
end