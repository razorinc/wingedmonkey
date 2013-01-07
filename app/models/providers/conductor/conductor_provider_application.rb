module Providers
  module Conductor
    class ConductorProviderApplication < ProviderApplication
      def launchable
        raise "Conductor does not currently support the association between provider applications and launchables."
      end

      def launch
        ## not implemented yet
      end

      def destroy
        ## not implemented yet
      end

      def self.all filter=nil
        connect! {|connection| connection.deployments}
      end

      def self.find id
        connect! do |connection|
          connection.deployments.find{|app| app.id.to_s == id}
        end
      end
    end
  end
end
