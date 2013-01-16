require 'spec_helper'

describe ProvidersController do
  describe "POST 'select'" do
    it "sets the current provider in the session" do
      post 'select', :provider_id => "my_mock"
      response.should redirect_to(login_path)
      session[:current_provider_id].should eq "my_mock"
    end
  end
end
