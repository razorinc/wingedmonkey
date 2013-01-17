require 'openstack'

class OpenStack::Compute::Flavor
  def ram_string
    @ram >= 1024 ? "#{@ram/1024}GB" : "#{@ram}MB"
  end

  def description
    "#{ram_string} RAM | #{@vcpus} VCPU | #{@disk}GB Disk"
  end

  def name_with_description
    "#{@name} [ #{description} ]"
  end
end
