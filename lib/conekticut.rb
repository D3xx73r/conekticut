# encoding: utf-8
require 'active_support/concern'
require 'hashie'

module Conekticut
  class << self
      def configure(&block)
        Conekticut::Client::Base.configure(&block)
      end

      def configure_resource(&block)
        Conekticut::Client::Resource.configure_resource(&block)
      end
    end
end

require "conekticut/version"
require "conekticut/client"
require "conekticut/client/resource"
