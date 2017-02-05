module Scaffold
  module Services
    class Route
      def initialize rails
        @rails = rails
      end

      # resources :company_ownerships
      def resource_name
        @rails.resource.collection_name
      end

      def nested?
        @rails.nested_in_resources.present?
      end


    end
  end
end