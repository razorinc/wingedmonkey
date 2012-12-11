require 'spec_helper'

describe LaunchablesController do

  describe "when not logged in" do
    describe "GET 'index'" do
      it "redirects to login" do
        get 'index'
        response.should redirect_to(login_path)
      end
    end
  end

  describe "when logged in as mock_user" do
    describe "GET 'index'" do
      it "responds with success" do
        as_user mock_user do
          get 'index'
          response.should be_success
        end
      end
    end
  end

end
