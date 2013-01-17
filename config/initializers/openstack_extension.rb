require 'openstack'

class OpenStack::Compute::Flavor
  def description
    "#{@ram/1024}GB RAM | #{@vcpus} VCPU | #{@disk}GB Disk"
  end

  def name_with_description
    "#{@name} [ #{description} ]"
  end
end
