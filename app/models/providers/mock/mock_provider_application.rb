module Providers
  module Mock
    class MockProviderApplication < ProviderApplication
      def launchable
        Launchable.find(@launchable_id)
      end

      def launch
        return false if not valid?
        @state = 'running'
        self.class.connect! do |connection|
          connection.add_application(self)
        end
      end

      def destroy
        self.class.connect! do |connection|
          connection.destroy_application(self)
        end
      end

      def self.all filter=nil
        connect! {|connection| connection.applications}
      end

      def self.find id
        connect! do |connection|
          connection.applications.find{|app| app.id.to_s == id}
        end
      end
    end
  end
end
