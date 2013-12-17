module Cryptopay
  module Request
    def self.to_uri(path)
      "https://cryptopay.me/api/v1/#{path}"
    end

    def self.request(verb, path, options={})
      verb = verb.upcase.to_sym

      options[:api_key] = Cryptopay.key

      resource = RestClient::Resource.new to_uri(path), content_type: 'application/json'
      begin
        if verb == :GET
          response = RestClient.get "#{to_uri(path)}?".concat(options.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&'))
        elsif verb == :POST
          response = resource.post options
        end

        return JSON.parse response

      rescue => e
        error = Cryptopay::Error.new "#{e.message} (#{e.class})"
        error.errors = JSON.parse(e.response)
        raise error
      end
    end

    def self.get(path, options={})
      self.request(:GET, path, options)
    end

    def self.post(path, options={})
      self.request(:POST, path, options)
    end
  end
end
