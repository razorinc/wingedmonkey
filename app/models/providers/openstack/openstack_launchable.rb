module Providers
  module OpenStack
    class OpenStackLaunchable < Launchable
      attr_accessor :state

      def self.all filter=nil
        launchables = []
        connect! {|connection|
          images_hash = connection.images
          images_hash.each do |image_hash|
            state = image_hash[:status]
            wm_state = (state == "ACTIVE") ? Launchable::WM_STATE_ACTIVE : Launchable::WM_STATE_INACTIVE
            launchables << Launchable.
              create({ :id => image_hash[:id],
                       :name => image_hash[:name],
                       :state => state,
                       :wm_state => wm_state
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
