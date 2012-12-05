module Providers
  module Mock
    class MockLaunchable < Launchable

      # List all of the launchable items.
      # The list may be reduced by the information in the current context.
      def self.all filter=nil
        connect! {|connection| connection.launchables}
      end

      def self.find(id)
        connect! do |connection|
          connection.launchables.find{|launchable| launchable.id.to_s == id}
        end
      end
    end
  end
end
