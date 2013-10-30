# encoding: utf-8

require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/class/attribute'
require 'active_support/concern'

module Conekticut
  class << self
      def configure(&block)
        Conekticut::Client::Base.configure(&block)
      end
    end
end

require "conekticut/version"
require "conekticut/client"
