# Copyright 2012-2013 Red Hat, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations
# under the License.

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
