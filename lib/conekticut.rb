# encoding: utf-8
require 'active_support/concern'

module Conekticut
  class << self
    def configure(&block)
      Conekticut::Client::Base.configure(&block)
    end
  end

  class Payment
    def self.create(url = nil, payment_info = {})
      Conekticut::Client::Payment.create(url, payment_info)
    end
  end
end

require "conekticut/version"
require "conekticut/client"
require "conekticut/sslcert"
require "conekticut/client/payment"
