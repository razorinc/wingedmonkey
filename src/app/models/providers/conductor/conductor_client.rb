module Providers
  module Conductor
    class ConductorClient
      include ActiveModel::Validations
      include ActiveModel::Conversion
      extend ActiveModel::Naming

      attr_accessor :username, :password, :url

      def initialize(username, password, url)
        @username = username
        @password = password
        @url = url
      end

      def valid_credentials?
        fetch_xml ""
      end

      def persisted?
        false
      end

      private

      def fetch_xml page
        resource = RestClient::Resource.new(@url + page + ".xml",
                                            :user => @username,
                                            :password => @password,
                                            :open_timeout => 10,
                                            :timeout => 45)
        begin
          response = resource.get
          if response.code == 200
            resource
          else
            false
          end
        rescue => e
          false
        end
      end

    end
  end
end
