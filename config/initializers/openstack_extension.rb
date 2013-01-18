require 'openstack'

class OpenStack::Compute::Flavor
  def description
    ram_string = ActionController::Base.helpers.number_to_human_size(@ram * 1024 * 1024)
    "#{ram_string} RAM | #{@vcpus} VCPU | #{@disk}GB Disk"
  end

  def name_with_description
    "#{@name} [ #{description} ]"
  end
end
