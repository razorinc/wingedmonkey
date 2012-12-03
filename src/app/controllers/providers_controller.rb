class ProvidersController < ApplicationController
  skip_before_filter :require_provider_authentication, :only => :select

  def select
    set_current_provider_id params[:provider_id]

    respond_to do |format|
      format.html { redirect_to login_path }
      format.js
    end
  end
end
