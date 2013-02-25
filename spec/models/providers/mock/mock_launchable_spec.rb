require 'spec_helper'
require 'ostruct'

describe Providers::Mock::MockLaunchable do

  describe "as an instance" do

  end

  describe "as a class" do

    before :all do
      @launchables = [
                      OpenStruct.new({:id => 1, :name => "first", :cost => 1}),
                      OpenStruct.new({:id => 2, :name => "second", :cost => 2}),
                      OpenStruct.new({:id => 3, :name => "third", :cost => 3}),
                      OpenStruct.new({:id => 4, :name => "fourth", :cost => 4})]

      @empty_launchables = []
    end

    it "returns an empty list of launchables" do
      connection = Object.new
      connection.stub!(:launchables).and_return(@empty_launchables)
      Providers::Mock::MockLaunchable.stub!(:connect!).and_yield(connection)
      Providers::Mock::MockLaunchable.all.should be_empty
    end

    it "lists all launchables" do
      connection = Object.new
      connection.stub!(:launchables).and_return(@launchables)
      Providers::Mock::MockLaunchable.stub!(:connect!).and_yield(connection)
      launchables = Providers::Mock::MockLaunchable.all
      launchables.should_not be_empty
      verify_hash = {1 => "first", 2 => "second", 3 => "third", 4 => "fourth"}
    launchable = launchables.first
      launchable.name.should eq verify_hash[launchable.id]
    end

    it "finds a specific launchable" do
      connection = Object.new
      connection.stub!(:launchables).and_return(@launchables)
      Providers::Mock::MockLaunchable.stub!(:connect!).and_yield(connection)
      launchable = Providers::Mock::MockLaunchable.find("1")
      launchable.name.should eq "first"
    end

  end
end
