module Providers
  module Ovirt
    class OvirtProviderApplication < ProviderApplication
      def launchable
        Launchable.find(@launchable_id)
      end

      def save
        @state = 'running'
        self.class.connect! do |connection|
          connection.create_vm(self)
        end
      end

      def destroy
        self.class.connect! do |connection|
          connection.destroy_vm id
        end
      end

      def self.all filter=nil
        connect! do |connection|
          connection.vms.map do |vm|
            map_vm_to_application vm
          end
        end
      end

      def self.find id
        connect! do |connection|
          vm = connection.vm id
          map_vm_to_application vm
        end
      end

      private
      def map_vm_to_application
      end
    end
  end
end
