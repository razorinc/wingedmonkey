module Providers
  module Ovirt
    class OvirtProviderApplication < ProviderApplication
      def launchable
        Launchable.find(@launchable_id)
      end

      def launch
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
            self.map_vm_to_application vm
          end
        end
      end

      def self.find id
        connect! do |connection|
          vm = connection.vm(id)
          self.map_vm_to_application vm
        end
      end

      private
      def self.map_vm_to_application vm
        OvirtProviderApplication.new({
          :id => vm.id,
          :name => vm.name,
          :description => vm.description,
          :status => vm.status.strip,
          :memory => vm.memory.strip,
          :cores => vm.cores
        })
      end

      def self.map_application_to_vm app
        vm_hash = {
          :name => app.name,
          :template => app.launchable.id, # template id from launchable
          :cluster => "", # need to store locally, I guess
          :memory => "", # should come from the template, or collect from user as override?
          :cores => "", # should come from template, or collect as override?, will default to 1
          :boot_dev1 => "", # defaults to network
          :boot_dev2 => "", # defaults to hd
          :display => "", # ???
        }
      end

      @states = {:up => "running", :down => "stopped"}
      def self.map_status status
        key = status.strip
        if @states.has_key? key
          @states[key]
        else
          "unknown"
        end
      end
    end
  end
end
