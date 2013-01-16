module Providers
  module Ovirt
    class OvirtLaunchable < Launchable

      # List all of the launchable items.
      # The list may be reduced by the information in the current context.
      def self.all filter=nil
        launchables = []
        connect! do |connection|
          connection.templates.map do |template|
            OvirtLaunchable.new(
              :id => template.id,
              :name => template.name,
              :description => template.description
            )
          end
        end
      end

      def self.find(id)
        self.all.find{|launchable| launchable.id.to_s == id.to_s}
      end
    end
  end
end
