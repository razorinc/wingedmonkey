require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  it "should create user session if valid credentials are provided" do
    session[:current_provider_id] = "my_mock"
    post :create, :params => { :username => "admin", :password => "password" }
    response.should redirect_to(root_url)
  end

  it "should not create user session if invalid credentials are provided" do
    session[:current_provider_id] = "test_conductor"
    post :create, :params => { :username => "admin", :password => "password" }
    response.should render_template("new")
  end

  describe "when logged in as mock_user" do
    describe "GET 'destroy'" do
      it "redirects to login" do
        get 'destroy'
        response.should redirect_to(login_path)
      end
    end
  end

end
