require 'spec_helper'

describe Providers::Conductor::ConductorLaunchable do
  before :all do
    Provider.current = Provider.find("test_conductor")

    @deployables = [
                    OpenStruct.new({:id => 1, :name => "first"}),
                    OpenStruct.new({:id => 2, :name => "second"}),
                    OpenStruct.new({:id => 3, :name => "third"}),
                    OpenStruct.new({:id => 4, :name => "fourth"}),
                   ]

    @empty_deployables = []
  end

  it "returns an empty list of launchables" do
    connection = Object.new
    connection.stub!(:deployables).and_return(@empty_deployables)
    Providers::Conductor::ConductorLaunchable.stub!(:connect!).and_yield(connection)
    Providers::Conductor::ConductorLaunchable.all.should be_empty
  end

  it "lists all provider applications" do
    connection = Object.new
    connection.stub!(:deployables).and_return(@deployables)
    Providers::Conductor::ConductorLaunchable.stub!(:connect!).and_yield(connection)
    deployables = Providers::Conductor::ConductorLaunchable.all
    deployables.should_not be_empty
    deployable = deployables.first
    deployable.name.should eq "first"
  end

  it "finds a specific provider application" do
    connection = Object.new
    connection.stub!(:deployables).and_return(@deployables)
    Providers::Conductor::ConductorLaunchable.stub!(:connect!).and_yield(connection)
    deployable = Providers::Conductor::ConductorLaunchable.find("2")
    deployable.name.should eq "second"
  end

end
