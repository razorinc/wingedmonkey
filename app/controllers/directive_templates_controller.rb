class DirectiveTemplatesController < ApplicationController
  respond_to :html

  def wm_provider_app_confirm
    render :layout => false
  end

  def wm_flash_message
    render :layout => false
  end
end
