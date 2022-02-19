# frozen_string_literal: true

require 'json'
require 'net/http'

module WeApi
  # Http client to interact with MetaWeather API
  class ApiClient
    BASE_URL = 'www.metaweather.com'

    def initialize(client = nil)
      if client
        @client = client
      else
        @client = Net::HTTP.new(BASE_URL, 443)
        @client.use_ssl = true
      end
    end

    # Make a http get request to metaweather api
    def call(path, query: [])
      res = @client.get(build_url(path, query))

      raise(res.body) unless res&.code == '200'

      JSON.parse(res.body)
    end

    private

    def build_url(path, query = [])
      path = path.sub(%r{^/}, '') if path.start_with?('/')
      path = "/api/#{path}"
      path += "?#{query.join('&')}" unless query.empty?

      path
    end
  end
end
