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

require 'open-uri'
module Providers
  module Conductor
    class ConductorClient
      include ActiveModel::Validations
      include ActiveModel::Conversion
      extend ActiveModel::Naming

      attr_accessor :username, :password, :url, :pool_id

      def initialize(username, password, url, pool_id)
        @username = username
        @password = password
        @url = url
        @pool_id = pool_id
      end

      def valid_credentials?
        begin
          xml ""
        rescue => e
          false
        end
      end

      def deployments
        doc = xml "/pools/" + @pool_id.to_s + "/deployments"
        deployments = []
        deployments_xml = doc.xpath("//deployment")
        deployments_xml.each do |deployment_xml|
          deployment_id = deployment_xml["id"];
          name = deployment_xml.xpath("name").text
          state = 'to be implemented'
          wm_state = ProviderApplication::WM_STATE_RUNNING
          deployable_id = nil
          deployments << ProviderApplication.
            create({ :id => deployment_id,
                     :name => name,
                     :state => state,
                     :wm_state => wm_state,
                     :launchable_id => deployable_id })
        end
        deployments
      end

      def deployables
        doc = xml "/pools/" + @pool_id.to_s + "/deployables"
        deployables = []
        deployables_xml = doc.xpath("//deployable")
        deployables_xml.each do |deployable_listing_xml|
          deployable_id = deployable_listing_xml["id"];
          deployable_doc = xml "/deployables/#{deployable_id}"
          deployable_xml = deployable_doc.root
          name = deployable_xml.xpath("name").text
          description = deployable_xml.xpath("description").text
          deployables << Launchable.
            create({ :id => deployable_id,
                     :name => name,
                     :description => description,
                     :wm_state => Launchable::WM_STATE_ACTIVE })
        end
        deployables
      end

      def persisted?
        false
      end

      private

      def xml page
        page_url = @url + page + ".xml"
        begin
          Nokogiri::XML(open(page_url,
                             :http_basic_authentication => [@username, @password],
                             :read_timeout => 10))
        rescue => e
          raise "Could not connect to Conductor at " + page_url + ": " + e.message
        end
      end
    end
  end
end
