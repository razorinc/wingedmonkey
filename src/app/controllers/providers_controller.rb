class ProvidersController < ApplicationController
  skip_before_filter :require_provider, :only => :select

  def select
    set_current_provider_id params[:provider_id]
    render :nothing => true
  end
end
