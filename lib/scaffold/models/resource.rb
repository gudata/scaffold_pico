module Scaffold
  module Models
    class Resource

      def initialize raw_input
        (@modules, @class_name) = parse_model(raw_input)
      end

      # company_ownership
      #
      # Doesn't include modules
      #
      # for usage in controllers: company_ownership = CompanyOwnership.find...
      # for usage in paths: link_to [company_ownership] do ...
      def name
        @class_name.tableize.singularize
      end

      def instance_name
        "@#{name}"
      end

      def param_name
        "#{name}_id"
      end

      # CompanyOwnership
      def class_name
        @class_name.singularize
      end

      def modules
        @modules
      end

      # is the resource in modules Reports::Payment
      def modules?
        @modules.blank?
      end

      # company_ownerships
      def collection_name
        @class_name.tableize
      end

      # Admin::User or only User
      def class_name_with_modules
        if modules.empty?
          class_name
        else
          "#{modules.join('::')}::#{class_name}"
        end
      end

      private

      # model is something like Admin::User
      def parse_model model
        chunks = model.split('::').select{|chunk| !chunk.empty?}
        class_name = chunks.pop
        [chunks, class_name]
      end

    end
  end
end