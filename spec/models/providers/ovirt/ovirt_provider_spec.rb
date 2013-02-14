require 'spec_helper'

describe Providers::Ovirt::OvirtProvider do

  it "indicates invalid credentials" do
    with_provider 'test_ovirt' do |provider|
      credentials = {:username => "admin", :password => "password"}
      provider.valid_credentials?(credentials).should be_false
    end
  end

end
