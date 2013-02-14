require 'spec_helper'

describe Providers::Ovirt::OvirtProviderApplication do
  describe "as an instance" do

    before :all do
      Provider.current = Provider.find("test_ovirt")

      @app = Providers::Ovirt::OvirtProviderApplication.
        new({
              :id => 1,
              :name => "name",
              :ips => [],
              :creation_time => Time.now,
              :memory => 0,
              :cores => 2
      })

      @vm = OpenStruct.new({:id => 1, :name => "first", :status => "  up  \n", :memory => "1234", :cores => 2, :ips => ["127.0.0.1"]});
    end

    it "returns the reference launchable" do
    end

    it "returns its custom attributes" do
      @app.attributes.has_key?("ips").should be_true
      @app.attributes.has_key?("creation_time").should be_true
      @app.attributes.has_key?("memory").should be_true
      @app.attributes.has_key?("cores").should be_true
    end

    it "returns the available actions if it is running" do
      @app.wm_state = ProviderApplication::WM_STATE_RUNNING
      @app.available_actions.include?(ProviderApplication::WM_ACTION_PAUSE).should be_true
      @app.available_actions.include?(ProviderApplication::WM_ACTION_STOP).should be_true
      @app.available_actions.include?(ProviderApplication::WM_ACTION_START).should be_false
      @app.available_actions.include?(ProviderApplication::WM_ACTION_TERMINATE).should be_false
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
      @app.available_actions.include?(ProviderApplication::WM_ACTION_TERMINATE).should be_false
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
      connection.stub!(:create_vm).and_return(@vm)
      Providers::Ovirt::OvirtProviderApplication.stub!(:connect!).and_yield(connection)

      app = Providers::Ovirt::OvirtProviderApplication.
        new({
              :name => "first",
              :launchable => OpenStruct.new({:id => "1"}),
              :cores => 2
            })

      app.launch
      app.id.should eq 1
    end

    it "starts itself" do
      connection = Object.new
      connection.stub!(:vm_action).with(an_instance_of(Fixnum),an_instance_of(Symbol)).and_return(nil)
      Providers::Ovirt::OvirtProviderApplication.stub!(:connect!).and_yield(connection)

      connection.should_receive(:vm_action).with(1,:start).once
      @app.start
    end

    it "stops itself" do
      connection = Object.new
      connection.stub!(:vm_action).with(an_instance_of(Fixnum),an_instance_of(Symbol)).and_return(nil)
      Providers::Ovirt::OvirtProviderApplication.stub!(:connect!).and_yield(connection)

      connection.should_receive(:vm_action).with(1,:shutdown).once
      @app.stop
    end

    it "pauses itself" do
      connection = Object.new
      connection.stub!(:vm_action).with(an_instance_of(Fixnum),an_instance_of(Symbol)).and_return(nil)
      Providers::Ovirt::OvirtProviderApplication.stub!(:connect!).and_yield(connection)

      connection.should_receive(:vm_action).with(1,:suspend).once
      @app.pause
    end

    it "destroys itself" do
      connection = Object.new
      connection.stub!(:destroy_vm).with(an_instance_of(Fixnum)).and_return(nil)
      Providers::Ovirt::OvirtProviderApplication.stub!(:connect!).and_yield(connection)

      connection.should_receive(:destroy_vm).with(1).once
      @app.destroy
    end
  end

  describe "as a class" do
    before :all do
      Provider.current = Provider.find("test_ovirt")

      @templates = [ OpenStruct.new({:id => "1"}) ]
      @vms = [
              OpenStruct.new({:id => 1, :name => "first", :description => "first template", :status => "  up  \n", :memory => "1234", :cores => 1, :ips => ["127.0.0.1"], :template => @templates[0]}),
              OpenStruct.new({:id => 2, :name => "second", :description => "second template", :status => "  up  \n", :memory => "1234", :ips => ["127.0.0.1"], :template => @templates[0]}),
              OpenStruct.new({:id => 3, :name => "third", :description => "third template", :status => "  up  \n", :memory => "1234", :ips => ["127.0.0.1"], :template => @templates[0]}),
              OpenStruct.new({:id => 4, :name => "fourth", :description => "fourth template", :status => "  up  \n", :memory => "1234", :ips => ["127.0.0.1"], :template => @templates[0]})
             ]

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
      connection = Object.new
      connection.stub!(:vms).and_return(@vms)
      Providers::Ovirt::OvirtProviderApplication.stub!(:connect!).and_yield(connection)
      Launchable.stub!(:all).and_return(@templates)
      apps = Providers::Ovirt::OvirtProviderApplication.all
      apps.should_not be_empty
      app = apps.first
      app.name.should eq "first"
    end

    it "finds a specific application" do
      connection = Object.new
      connection.stub!(:vm).and_return(@vms[1])
      Providers::Ovirt::OvirtProviderApplication.stub!(:connect!).and_yield(connection)
      Launchable.stub!(:all).and_return(@templates)
      app = Providers::Ovirt::OvirtProviderApplication.find("2")
      app.name.should eq "second"
    end
  end
end
