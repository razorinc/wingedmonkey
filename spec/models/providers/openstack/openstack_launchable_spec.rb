require 'spec_helper'

describe Providers::OpenStack::OpenStackLaunchable do
  describe "as an instance" do

    before :all do
      Provider.current = Provider.find("test_ovirt")

      @launchable = Providers::OpenStack::OpenStackProviderApplication.
        new({
              :id => 1,
              :name => "name",
              :state => "thumbsup",
      })
    end

  end

  describe "as a class" do

    before :all do
      Provider.current = Provider.find("test_openstack")

      @images = [
                 {:id => "1", :name => "first", :description => "first image", :status => "ACTIVE"},
                 {:id => "2", :name => "second", :description => "second image", :status => "ACTIVE"},
                 {:id => "3", :name => "third", :description => "third image", :status => "ACTIVE"},
                 {:id => "4", :name => "fourth", :description => "fourth image", :status => "ACTIVE"}
                ]

      @empty_images = []
    end

    it "returns an empty list of launchables" do
      connection = Object.new
      connection.stub!(:images).and_return(@empty_images)
      Providers::OpenStack::OpenStackLaunchable.stub!(:connect!).and_yield(connection)
      Providers::OpenStack::OpenStackLaunchable.all.should be_empty
    end

    it "lists all launchables" do
      connection = Object.new
      connection.stub!(:images).and_return(@images)
      Providers::OpenStack::OpenStackLaunchable.stub!(:connect!).and_yield(connection)
      launchables = Providers::OpenStack::OpenStackLaunchable.all
      launchables.should_not be_empty
      launchable = launchables.first
      launchable.name.should eq "first"
    end

    it "finds a specific launchable" do
      connection = Object.new
      connection.stub!(:images).and_return(@images)
      Providers::OpenStack::OpenStackLaunchable.stub!(:connect!).and_yield(connection)
      launchable = Providers::OpenStack::OpenStackLaunchable.find("1")
      launchable.name.should eq "first"
    end

  end
end
