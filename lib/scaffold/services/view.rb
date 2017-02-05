module Scaffold
  module Services
    class View
      def initialize rails
        @rails = rails
      end

      def folder_name
        @rails.resource.collection_name
      end

    end
  end
end