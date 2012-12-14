module Providers
  module OpenStack
    class OpenStackProviderApplication < ProviderApplication
      attr_accessor :flavor_id

      def launchable
        Launchable.find(@launchable_id)
      end

      def flavor
        self.class.connect! {|connection|
          connection.get_flavor(@flavor_id)
        }
      end

      def save
        self.class.connect! {|connection|
          server = connection.create_server(:name => @name,
                                            :imageRef => @launchable_id,
                                            :flavorRef => @flavor_id)
          @id = server.id
        }
      end

      def destroy
        self.class.connect! {|connection|
          server = connection.get_server(@id)
          server.delete!
        }
      end

      def self.all filter=nil
        apps = []
        connect! {|connection|
          servers_hash = connection.list_servers_detail
          servers_hash.each do |server_hash|
            apps << ProviderApplication.
              create({ :id => server_hash[:id],
                       :name => server_hash[:name],
                       :state => server_hash[:status],
                       :launchable_id => server_hash[:image][:id],
                       :flavor_id => server_hash[:flavor][:id]
                     })
          end
        }
        apps
      end

      def self.find id
        self.all.find{|app| app.id.to_s == id}
      end
    end
  end
end
