module Providers
  module Conductor
    class ConductorProvider < Provider
      attr_accessor :pool_id

      def valid_credentials? credentials
        @credentials = credentials
        client = connect!
        client.valid_credentials?
      end

      def connect!
        Providers::Conductor::ConductorClient.
          new(@credentials[:username], @credentials[:password], url, pool_id)
      end
    end
  end
end
