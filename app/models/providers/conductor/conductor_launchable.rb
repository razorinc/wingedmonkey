module Providers
  module Conductor
    class ConductorLaunchable < Launchable

      def self.all filter=nil
        filter ||= {}
      end

      def self.find(id)
        nil
      end
    end
  end
end
