module ApplicationHelper
  def render_provider_partial(partial_name, locals = {})
    provider_name = current_provider.type
    if provider_partial_exists?(provider_name, partial_name)
      partial = provider_partial(provider_name, partial_name)
    elsif provider_partial_exists?("default", partial_name)
      partial = provider_partial("default", partial_name)
    end

    if partial
      render :partial => partial, :locals => locals
    end
  end

  def authenticated?
    session[:current_provider_creds].present?
  end

  private
  def provider_partial(provider_name, partial_name)
    provider_name + "/" + partial_name
  end

  def provider_partial_exists?(provider_name, partial_name)
    partial_file = ::Rails.root.to_s + "/app/views/" + provider_name + "/_" + partial_name + ".html.haml"
    File.exists?(partial_file)
  end
end
