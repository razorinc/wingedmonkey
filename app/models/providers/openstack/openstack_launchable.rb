module Providers
  module OpenStack
    class OpenStackLaunchable < Launchable
      attr_accessor :state

      def self.all filter=nil
        launchables = []
        connect! {|connection|
          images_hash = connection.images
          images_hash.each do |image_hash|
            launchables << Launchable.
              create({ :id => image_hash[:id],
                       :name => image_hash[:name],
                       :state => image_hash[:status]
                     })
          end
        }
        launchables
      end

      def self.find(id)
        self.all.find{|app| app.id.to_s == id}
      end
    end
  end
end
