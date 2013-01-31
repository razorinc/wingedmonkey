require 'spec_helper'

describe Providers::Mock::MockProvider do
  before :all do
    @credentials = {:username => "admin", :password => "password"}
  end

  it "indicates valid credentials" do
    with_provider 'my_mock' do |provider|
      provider.valid_credentials?(@credentials).should be_true
    end
  end

end
