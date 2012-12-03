require 'rbovirt'

module Providers
  module Ovirt

    class OvirtProvider < Provider
      attr_accessor :datacenter

      def valid_credentials? credentials
        client = connect!(credentials)
        begin
          client.api_version
        rescue => e
          false
        end
        true
      end

      def connect! credentials
        OVIRT::Client.new(credentials[:username], credentials[:password], url, datacenter)
      end
    end
  end
end
