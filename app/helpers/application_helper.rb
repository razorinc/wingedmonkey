module ApplicationHelper
  def render_provider_partial(partial_name, locals = {})
    partial = provider_partial(partial_name)
    if partial
      render :partial => partial, :locals => locals
    end
  end

  def authenticated?
    session[:current_provider_creds].present?
  end

  def seconds_to_time_string(seconds)
    if seconds
      remaining_seconds = seconds.to_i
      time_string = ""
      if remaining_seconds > 86400
        time_string += "#{remaining_seconds / 86400}d, "
        remaining_seconds = remaining_seconds % 86400
      end
      if remaining_seconds > 3600
        time_string += "#{remaining_seconds / 3600}h, "
        remaining_seconds = remaining_seconds % 3600
      end
      if remaining_seconds > 60
        time_string += "#{remaining_seconds / 60}m, "
        remaining_seconds = remaining_seconds % 60
      end
      time_string += "#{remaining_seconds}s"
    else
      "N/A"
    end
  end

  private
  def provider_partial(partial_name)
    provider_name = current_provider.type
    if partial_exists?(provider_name, partial_name)
      provider_name + "/" + partial_name
    elsif partial_exists?("default", partial_name)
      "default/" + partial_name
    end
  end

  def partial_exists?(provider_name, partial_name)
    partial_file = ::Rails.root.to_s + "/app/views/" + provider_name + "/_" + partial_name + ".html.haml"
    File.exists?(partial_file)
  end

  def title(page_title)
    content_for(:title) { page_title }
  end
end
