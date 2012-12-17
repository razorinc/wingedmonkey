require 'spec_helper'

describe Providers::Conductor::ConductorClient do

  it "returns a list of deployments", :vcr, record: :none do
    with_provider 'test_conductor' do |provider|
      client = conductor_client("admin", "password", provider)
      client.deployments.should_not be_empty
    end
  end

  it "indicates invalid credentials" do
    with_provider 'test_conductor' do |provider|
      client = conductor_client("admin", "password", provider)
      client.stub!(:xml).and_raise("BOOM")
      client.valid_credentials?.should be_false
    end

  end
end

def conductor_client(username, password, provider)
  Providers::Conductor::ConductorClient.new(username, password, provider.url, provider.pool_id)
end
