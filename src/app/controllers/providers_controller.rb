class ProvidersController < ApplicationController
  def select
    set_current_provider params[:provider]
    render :nothing => true
  end
end
