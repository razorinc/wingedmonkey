require 'spec_helper'

describe Providers::OpenStack::OpenStackProviderApplication do
  describe "as an instance" do

    before :all do
      Provider.current = Provider.find("test_ovirt")

      @app = Providers::OpenStack::OpenStackProviderApplication.
        new({
              :id => 1,
              :name => "name",
              :flavor_id => 1,
              :ip_addresses => [],
              :created_at => Time.now,
      })

      @server = OpenStruct.new({:id => 1, :name => "first"});
    end

    it "returns its custom attributes" do
      @app.attributes.has_key?("flavor_id").should be_true
      @app.attributes.has_key?("ip_addresses").should be_true
      @app.attributes.has_key?("created_at").should be_true
    end

    it "returns the available actions if it is running" do
      @app.wm_state = ProviderApplication::WM_STATE_RUNNING
      @app.available_actions.include?(ProviderApplication::WM_ACTION_PAUSE).should be_false
      @app.available_actions.include?(ProviderApplication::WM_ACTION_STOP).should be_false
      @app.available_actions.include?(ProviderApplication::WM_ACTION_START).should be_false
      @app.available_actions.include?(ProviderApplication::WM_ACTION_TERMINATE).should be_true
    end

    it "returns the available actions if it is failed" do
      @app.wm_state = ProviderApplication::WM_STATE_FAILED
      @app.available_actions.include?(ProviderApplication::WM_ACTION_PAUSE).should be_false
      @app.available_actions.include?(ProviderApplication::WM_ACTION_STOP).should be_false
      @app.available_actions.include?(ProviderApplication::WM_ACTION_START).should be_false
      @app.available_actions.include?(ProviderApplication::WM_ACTION_TERMINATE).should be_true
    end

    it "launches itself" do
      connection = Object.new
      connection.stub!(:create_server).and_return(@server)
      Providers::OpenStack::OpenStackProviderApplication.stub!(:connect!).and_yield(connection)

      app = Providers::OpenStack::OpenStackProviderApplication.
        new({
              :name => "first",
              :launchable => OpenStruct.new({:id => "1"}),
              :flavor_id => 1
            })

      app.launch
      app.id.should eq 1
    end

    it "destroys itself" do
      @server.stub!(:delete!).and_return(nil)
      connection = Object.new
      connection.stub!(:get_server).with(an_instance_of(Fixnum)).and_return(@server)
      Providers::OpenStack::OpenStackProviderApplication.stub!(:connect!).and_yield(connection)

      connection.should_receive(:get_server).with(1).once
      @server.should_receive(:delete!).once
      @app.destroy
    end
  end

  describe "as a class" do

    before :all do
      Provider.current = Provider.find("test_openstack")
      
      @flavors = [
                  {:id => "1", :name => "tiny"},
                  {:id => "2", :name => "small"},
                  {:id => "3", :name => "medium"},
                  {:id => "4", :name => "large"},
                 ]
      
      @servers = [
                  {:id => "1", :name => "first", :description => "first image", :status => "ACTIVE", :image => {:id => "1"}, :flavor => {:id => "1"}, :addresses=>{:public=>[], :private=>[{:addr=>"0.0.0.0"}]}, :created => Time.now.to_s},
                  {:id => "2", :name => "second", :description => "second image", :status => "ACTIVE", :image => {:id => "1"}, :flavor => {:id => "2"}, :addresses=>{:public=>[], :private=>[{:addr=>"0.0.0.0"}]}, :created => Time.now.to_s},
                  {:id => "3", :name => "third", :description => "third image", :status => "ACTIVE", :image => {:id => "1"}, :flavor => {:id => "3"}, :addresses=>{:public=>[], :private=>[{:addr=>"0.0.0.0"}]}, :created => Time.now.to_s},
                  {:id => "4", :name => "fourth", :description => "fourth image", :status => "ACTIVE", :image => {:id => "1"}, :flavor =>  {:id => "4"}, :addresses=>{:public=>[], :private=>[{:addr=>"0.0.0.0"}]}, :created => Time.now.to_s}
                 ]
      
      @empty_servers = []
    end
    
    it "returns an empty list of provider applications" do
      connection = Object.new
      connection.stub!(:list_servers_detail).and_return(@empty_servers)
      Providers::OpenStack::OpenStackProviderApplication.stub!(:connect!).and_yield(connection)
      Launchable.stub!(:all).and_return([])
      Providers::OpenStack::OpenStackProviderApplication.all.should be_empty
    end
    
    it "lists all provider applications" do
      connection = Object.new
      connection.stub!(:list_servers_detail).and_return(@servers)
      Providers::OpenStack::OpenStackProviderApplication.stub!(:connect!).and_yield(connection)
      Launchable.stub!(:all).and_return([])
      apps = Providers::OpenStack::OpenStackProviderApplication.all
      apps.should_not be_empty
      app = apps.first
      app.name.should eq "first"
    end
    
    it "finds a specific provider application" do
      connection = Object.new
      connection.stub!(:list_servers_detail).and_return(@servers)
      connection.stub!(:get_flavor).with(an_instance_of(String)).and_return(@flavors[1])
      Providers::OpenStack::OpenStackProviderApplication.stub!(:connect!).and_yield(connection)
      Launchable.stub!(:all).and_return([])
      app = Providers::OpenStack::OpenStackProviderApplication.find("2")
      app.name.should eq "second"
      app.flavor[:name].should eq "small"
    end
    
  end
end
