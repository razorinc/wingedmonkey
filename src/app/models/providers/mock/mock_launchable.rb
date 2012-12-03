module Providers
  module Mock
    class MockLaunchable < Launchable

      # List all of the launchable items.
      # The list may be reduced by the information in the current context.
      def self.all filter=nil
        connection = Provider.current_provider.connect!
        connection.launchables
      end

      def self.find(id)
        connection = Provider.current_provider.connect!
        connection.launchables.find{ |launchable| launchable.id.to_s == id }
      end
    end
  end
end
