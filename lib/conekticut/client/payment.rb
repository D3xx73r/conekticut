require "base64"
require "rest_client"
require "multi_json"
require "conekticut/client/configuration"

module Conekticut
  module Client
    class Payment
      def self.create(url = nil, payment_info = {})
        unless RequestHandler.has_valid_api_key?
          raise StandardError, "Please, verify your api key."
        end

        request_options = {
          :headers => {
            :user_agent => "Conekta/v1 RubyBindings/#{Base.conekta_version}",
            :authorization => "Basic #{::Base64.encode64("#{Base.private_key}:")}",
            :accept=>"application/vnd.conekta-v#{ Base.api_version }+json"
          }, :method => :post, :open_timeout => 30,
          :payload => payment_info, :url => RequestHandler.format_api_path(url),
          :timeout => 80
        }

        if RequestHandler.require_ssl?
          request_options.update(:verify_ssl => OpenSSL::SSL::VERIFY_PEER,
            :ssl_ca_file => Base.ssl_cert_path)
        end

        unless payment_info.respond_to? :to_hash
          raise StandardError, "Expected: Hash, got: #{params.class}"
        end

        full_request_url = RequestHandler.format_api_path(url)

        begin
          response = ::RestClient::Request.execute(request_options)
        rescue RestClient::UnprocessableEntity => e
          return { "status" => 422, "message" => e.message }
        end

        ::MultiJson.load response
      end
    end
  end
end
