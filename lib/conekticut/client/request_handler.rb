module Conekticut
  module Client
    class RequestHandler
      def self.has_valid_api_key?
        public_key = Conekticut::Client::Base.public_key
        not public_key.empty? and not public_key =~ /\s/
      end

      def self.require_ssl?
        if Conekticut::Client::Base.use_ssl == true
          ssl_cert = OpenSSL::PKey::RSA.new File.read(
            Conekticut::SSLCert.new(Conekticut::Client::Base.ssl_cert_path)
          )
        else
          puts "You are not using SSL Certs. We recommend to use it to avoid risks."
        end
      end

      def self.format_api_path(request)
        if request.end_with? ".json"
          "#{Base.api_base_path}/#{request}"
        else
          "#{Base.api_base_path}/#{request}.json"
        end
      end
    end
  end
end
