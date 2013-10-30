require "conekticut/client/configuration"

module Conekticut
  module Client
    class Base
      attr_reader :file

      include Conekticut::Client::Configuration
    end # end Base
  end # end Client
end # end Conekticut
