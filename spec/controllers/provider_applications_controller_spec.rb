require 'spec_helper'

describe ProviderApplicationsController do

  describe "when not logged in" do
    describe "GET 'index'" do
      it "redirects to login" do
        get 'index'
        response.should redirect_to(login_path)
      end
    end

    describe "GET 'new'" do
      it "redirects to login" do
        get 'new'
        response.should redirect_to(login_path)
      end
    end
  end

  describe "when logged into mock provider" do
    describe "GET 'index'" do
      it "responds with success" do
        as_user mock_user do
          get 'index'
          response.should be_success
        end
      end
    end

    describe "GET 'new'" do
      it "redirects to select launchable when no launchable_id" do
        as_user mock_user do
          get 'new'
          response.should redirect_to(launchables_path)
        end
      end

      it "responds with success when launchable_id provided" do
        as_user mock_user do
          get 'new', {:launchable_id => 1}
          response.should be_success
        end
      end
    end
  end

end
