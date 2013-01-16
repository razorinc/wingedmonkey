require 'spec_helper'
require 'ostruct'

describe Providers::Ovirt::OvirtLaunchable do
  before :all do
    @templates = [
      OpenStruct.new({:id => 1, :name => "first", :description => "first template"}),
      OpenStruct.new({:id => 2, :name => "second", :description => "second template"}),
      OpenStruct.new({:id => 3, :name => "third", :description => "third template"}),
      OpenStruct.new({:id => 4, :name => "fourth", :description => "fourth template"})]

    @empty_templates = []
  end

  it "returns an empty list of launchables" do
    connection = Object.new
    connection.stub!(:templates).and_return(@empty_templates)
    Providers::Ovirt::OvirtLaunchable.stub!(:connect!).and_yield(connection)
    Providers::Ovirt::OvirtLaunchable.all.should be_empty
  end

  it "lists all launchables" do
    connection = Object.new
    connection.stub!(:templates).and_return(@templates)
    Providers::Ovirt::OvirtLaunchable.stub!(:connect!).and_yield(connection)
    launchables = Providers::Ovirt::OvirtLaunchable.all
    launchables.should_not be_empty
    verify_hash = {1 => "first", 2 => "second", 3 => "third", 4 => "fourth"}
    launchable = launchables.first
    launchable.name.should eq verify_hash[launchable.id]
  end

  it "finds a specific launchable" do
    connection = Object.new
    connection.stub!(:templates).and_return(@templates)
    Providers::Ovirt::OvirtLaunchable.stub!(:connect!).and_yield(connection)
    launchable = Providers::Ovirt::OvirtLaunchable.find(1)
    launchable.name.should eq "first"
  end

end
