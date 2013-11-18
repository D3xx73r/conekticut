require "conekticut/client/configuration"
require "conekticut/client/request_handler"

module Conekticut
  module Client
    class Base
      attr_reader :file

      include Conekticut::Client::Configuration
    end # end Base
  end # end Client
end # end Conekticut
