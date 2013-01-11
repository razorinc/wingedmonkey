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
          deployable_id = nil
          deployments << ProviderApplication.
            create({ :id => deployment_id,
                     :name => name,
                     :state => state,
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
                     :description => description })
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
