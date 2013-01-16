require 'spec_helper'

describe ApplicationHelper do
  include ApplicationHelper

  def current_provider
    o = Object.new
    o.instance_eval do
      def type
        "mock"
      end
    end
    o
  end

  it "indicates whether that the current user is unauthenticated" do
    authenticated?.should be_false
  end

  it "indicates whether that the current user is authenticated" do
    session[:current_provider_creds] = true
    authenticated?.should be_true
  end

  it "finds a provider partial" do
    File.stub!(:exists?).and_return(true)
    partial = provider_partial("partial_name")
    partial.should eq "mock/partial_name"
  end

  it "finds a default partial" do
    # return false first call, return true second call
    File.stub!(:exists?).and_return(false, true)
    partial = provider_partial("partial_name")
    partial.should eq "default/partial_name"
  end

  it "indicates that a provider partial can be found" do
    File.stub!(:exists?).and_return(true)
    partial_exists?("partial", "exists").should be_true
  end

  it "indicates that a provider partial cannot be found" do
    File.stub!(:exists?).and_return(false)
    partial_exists?("partial", "exists").should be_false
  end
end
