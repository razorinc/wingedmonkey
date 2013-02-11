require 'spec_helper'

describe Providers::Ovirt::OvirtProviderApplication do
  describe "as an instance" do
    it "returns the reference launchable" do
    end

    it "destroys itself" do
      connection = Object.new
      connection.stub!(:destroy_vm).with(an_instance_of(Fixnum)).and_return(nil)
      Providers::Ovirt::OvirtProviderApplication.stub!(:connect!).and_yield(connection)

      obj = Providers::Ovirt::OvirtProviderApplication.new({
        :id => 1,
        :name => "name"
      })

      connection.should_receive(:destroy_vm).with(1).once
      obj.destroy
    end
  end

  describe "as a class" do
    before :all do
      @vms = [
        OpenStruct.new({:id => 1, :name => "first", :description => "first template", :status => "  up  \n", :memory => "1234", :cores => 1}),
        OpenStruct.new({:id => 2, :name => "second", :description => "second template"}),
        OpenStruct.new({:id => 3, :name => "third", :description => "third template"}),
        OpenStruct.new({:id => 4, :name => "fourth", :description => "fourth template"})]

      @empty_vms = []
    end

    it "returns an empty list" do
      connection = Object.new
      connection.stub!(:vms).and_return(@empty_vms)
      Providers::Ovirt::OvirtProviderApplication.stub!(:connect!).and_yield(connection)
      Launchable.stub!(:all).and_return([])
      Providers::Ovirt::OvirtProviderApplication.all.should be_empty
    end

    it "lists all applications" do
    end

    it "finds a specific application" do
    end
  end
end
