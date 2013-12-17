require "cryptopay/version"
require 'rest_client'
require 'net/http'
require 'cryptopay/net'

module Cryptopay
  class Error < Exception; attr_accessor :errors; end
  # API Key
  mattr_accessor :key

  def self.new_invoice(params = {})
    sanity_check!

    Cryptopay::Request.post 'invoices', params
  end

  def self.invoice uuid
    Cryptopay::Request.get "invoices/#{uuid}"
  end

  def self.configured?
    self.key
  end

  def self.sanity_check!
    unless configured?
      raise Exception.new("Cryptopay Gem not properly configured")
    end
  end

end
