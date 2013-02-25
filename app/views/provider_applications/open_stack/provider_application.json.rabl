object @provider_application

attributes :id, :launchable, :name, :state, :wm_state, :flavor_id, :ip_addresses, :created_at

node(:available_actions) { |app| app.available_actions }
node(:uptime) { |app| time_ago_in_words(app.created_at) }

child :flavor do
  node(:name_with_description) { |flavor| flavor.name_with_description }
end
