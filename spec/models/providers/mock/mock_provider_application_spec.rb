require 'spec_helper'

describe Providers::Mock::MockProviderApplication do
  describe "as an instance" do

    before :all do
      Provider.current = Provider.find("my_mock")

      @app = Providers::Mock::MockProviderApplication.
        new({
              :id => 1,
              :name => "name",
      })

    end

    it "returns its custom attributes" do
    end

    it "returns the available actions if it is running" do
      @app.wm_state = ProviderApplication::WM_STATE_RUNNING
      @app.available_actions.include?(ProviderApplication::WM_ACTION_PAUSE).should be_true
      @app.available_actions.include?(ProviderApplication::WM_ACTION_STOP).should be_true
      @app.available_actions.include?(ProviderApplication::WM_ACTION_START).should be_false
      @app.available_actions.include?(ProviderApplication::WM_ACTION_TERMINATE).should be_true
    end

    it "returns the available actions if it is stopped" do
      @app.wm_state = ProviderApplication::WM_STATE_STOPPED
      @app.available_actions.include?(ProviderApplication::WM_ACTION_PAUSE).should be_false
      @app.available_actions.include?(ProviderApplication::WM_ACTION_STOP).should be_false
      @app.available_actions.include?(ProviderApplication::WM_ACTION_START).should be_true
      @app.available_actions.include?(ProviderApplication::WM_ACTION_TERMINATE).should be_true
    end

    it "returns the available actions if it is paused" do
      @app.wm_state = ProviderApplication::WM_STATE_PAUSED
      @app.available_actions.include?(ProviderApplication::WM_ACTION_PAUSE).should be_false
      @app.available_actions.include?(ProviderApplication::WM_ACTION_STOP).should be_true
      @app.available_actions.include?(ProviderApplication::WM_ACTION_START).should be_true
      @app.available_actions.include?(ProviderApplication::WM_ACTION_TERMINATE).should be_true
    end

    it "returns the available actions if it is failed" do
      @app.wm_state = ProviderApplication::WM_STATE_FAILED
      @app.available_actions.include?(ProviderApplication::WM_ACTION_PAUSE).should be_false
      @app.available_actions.include?(ProviderApplication::WM_ACTION_STOP).should be_false
      @app.available_actions.include?(ProviderApplication::WM_ACTION_START).should be_false
      @app.available_actions.include?(ProviderApplication::WM_ACTION_TERMINATE).should be_true
    end

  end

  describe "as a class" do

    before :all do
      Provider.current = Provider.find("my_mock")
      
      @apps = [
               OpenStruct.new({:id => 1, :name => "first"}),
               OpenStruct.new({:id => 2, :name => "second"}),
               OpenStruct.new({:id => 3, :name => "third"}),
               OpenStruct.new({:id => 4, :name => "fourth"}),
              ]
      
      @empty_apps = []
    end
    
    it "returns an empty list of provider applications" do
      connection = Object.new
      connection.stub!(:applications).and_return(@empty_apps)
      Providers::Mock::MockProviderApplication.stub!(:connect!).and_yield(connection)
      Launchable.stub!(:all).and_return([])
      Providers::Mock::MockProviderApplication.all.should be_empty
    end
    
    it "lists all provider applications" do
      connection = Object.new
      connection.stub!(:applications).and_return(@apps)
      Providers::Mock::MockProviderApplication.stub!(:connect!).and_yield(connection)
      Launchable.stub!(:all).and_return([])
      apps = Providers::Mock::MockProviderApplication.all
      apps.should_not be_empty
      app = apps.first
      app.name.should eq "first"
    end
    
    it "finds a specific provider application" do
      connection = Object.new
      connection.stub!(:applications).and_return(@apps)
      Providers::Mock::MockProviderApplication.stub!(:connect!).and_yield(connection)
      Launchable.stub!(:all).and_return([])
      app = Providers::Mock::MockProviderApplication.find("2")
      app.name.should eq "second"
    end
    
    it "finds a specific provider application" do
      connection = Object.new
      connection.stub!(:applications).and_return(@apps)
      Providers::Mock::MockProviderApplication.stub!(:connect!).and_yield(connection)
      Launchable.stub!(:all).and_return([])
      app = Providers::Mock::MockProviderApplication.find("2")
      app.name.should eq "second"
    end

  end
end
