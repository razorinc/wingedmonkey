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

    describe "POST 'create'" do
      it "responds with success when there are no errors" do
        as_user mock_user do
          post "create", :provider_application => {:launchable_id => 1, :name => "New application"}
          app = ProviderApplication.all.last
          response.should redirect_to(launch_summary_provider_application_path(app.id))
        end
      end

      it "renders 'new' when parameters are missing" do
        as_user mock_user do
          post "create", :provider_application => {}
          response.should render_template("new")
        end
      end
    end

    describe "POST 'destroy'" do

      it "redirects to provider applications" do
        as_user mock_user do
          params = {:launchable_id => 1, :name => "New application"}
          application = Providers::Mock::MockProviderApplication.new(params)
          application.save
          post "destroy", {:id => application.id}
          response.should redirect_to(provider_applications_path)
        end
      end
    end
  end
end
