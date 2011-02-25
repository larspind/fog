require 'fog/core/model'
require 'fog/dns/models/dnsimple/records'

module Fog
  module DNSimple
    class DNS

      class Zone < Fog::Model

        identity :id,          :aliases => "name"

        attribute :domain,     :aliases => "name"
        attribute :created_at
        attribute :updated_at

        def destroy
          requires :identity
          connection.delete_domain(identity)
          true
        end

        def records
          @records ||= begin
                         Fog::DNSimple::DNS::Records.new(
                                                    :zone       => self,
                                                    :connection => connection
                                                    )
                       end
        end

        def nameservers
          [
           "ns1.dnsimple.com",
           "ns2.dnsimple.com",
           "ns3.dnsimple.com",
           "ns4.dnsimple.com",
          ]
        end

        def save
          requires :domain
          data = connection.create_domain(domain).body["domain"]
          true
        end

      end

    end
  end
end
