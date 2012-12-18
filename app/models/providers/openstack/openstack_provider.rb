require 'openstack'

module Providers
  module OpenStack
    class OpenStackProvider < Provider
      attr_accessor :tenant

      def valid_credentials? credentials
        @credentials = credentials
        begin
          connect!
        rescue => e
          false
        end
      end

      def connect!
        ::OpenStack::Connection.
          create({
                   :username => @credentials[:username],
                   :api_key => @credentials[:password],
                   :auth_method => 'password',
                   :auth_url => url,
                   :authtenant_name => tenant
                 })
      end

      def flavors
        flavors = []
        connection = connect!
        flavors_hash = connection.flavors
        flavors_hash.each do |flavor_hash|
          flavors << connection.get_flavor(flavor_hash[:id])
        end
        flavors
      end
    end
  end
end
