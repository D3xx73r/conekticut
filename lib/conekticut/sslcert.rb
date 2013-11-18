require "conekticut"
require "conekticut/client"

module Conekticut
  class SSLCert
    def initialize(path = nil)
      @ssl_path = path || Conekticut::Client::Base.ssl_cert_path
    end

    def to_path
      @ssl_path.to_s
    end
  end
end
