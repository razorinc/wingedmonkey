require 'spec_helper'

describe Providers::Mock::MockConnection do

  it "should be able to start and terminate applications" do
    connection = Providers::Mock::MockConnection.new
    initial_length = connection.applications.length
    launchable = mock_model(Launchable, :id => "1")

    app = Providers::Mock::MockProviderApplication.new({                                                 
                                                         :name => "name",
                                                         :launchable => launchable
                                                       })

    connection.add_application(app)
    connection.applications.length.should eq (initial_length + 1)

    connection.destroy_application(app)
    connection.applications.length.should eq initial_length
  end

end
