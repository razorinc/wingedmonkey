module Providers
  module Conductor
    class ConductorProvider < Provider
      def valid_credentials? credentials
        client = connect! credentials
        client.valid_credentials?
      end

      def connect! credentials
        Providers::Conductor::ConductorClient.
          new(credentials[:username], credentials[:password], url)
      end
    end
  end
end
