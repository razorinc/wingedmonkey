require 'spec_helper'

describe Providers::Conductor::ConductorProviderApplication do
  before :all do
    Provider.current = Provider.find("test_conductor")

    @deployments = [
                    OpenStruct.new({:id => 1, :name => "first"}),
                    OpenStruct.new({:id => 2, :name => "second"}),
                    OpenStruct.new({:id => 3, :name => "third"}),
                    OpenStruct.new({:id => 4, :name => "fourth"}),
                   ]

    @empty_deployments = []
  end

  it "returns an empty list of provider applications" do
    connection = Object.new
    connection.stub!(:deployments).and_return(@empty_deployments)
    Providers::Conductor::ConductorProviderApplication.stub!(:connect!).and_yield(connection)
    Providers::Conductor::ConductorProviderApplication.all.should be_empty
  end

  it "lists all provider applications" do
    connection = Object.new
    connection.stub!(:deployments).and_return(@deployments)
    Providers::Conductor::ConductorProviderApplication.stub!(:connect!).and_yield(connection)
    deployments = Providers::Conductor::ConductorProviderApplication.all
    deployments.should_not be_empty
    deployment = deployments.first
    deployment.name.should eq "first"
  end

  it "finds a specific provider application" do
    connection = Object.new
    connection.stub!(:deployments).and_return(@deployments)
    Providers::Conductor::ConductorProviderApplication.stub!(:connect!).and_yield(connection)
    deployment = Providers::Conductor::ConductorProviderApplication.find("2")
    deployment.name.should eq "second"
  end

end
