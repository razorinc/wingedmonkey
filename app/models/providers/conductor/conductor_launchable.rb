module Providers
  module Conductor
    class ConductorLaunchable < Launchable

      def self.all filter=nil
        connect! {|connection| connection.deployables}
      end

      def self.find id
        connect! do |connection|
          connection.deployables.find{|launchable| launchable.id.to_s == id}
        end
      end
    end
  end
end
