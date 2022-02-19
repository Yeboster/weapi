# frozen_string_literal: true

require 'json'
require 'net/http'

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
    res = @client.get build_url(path, query)

    JSON.parse(res&.body) if res&.body
  end

  private

  def build_url(path, query = [])
    path.sub!(%r{^/}, '') if path.start_with? '/'
    path = "/api/#{path}"
    path += "?#{query.join('&')}" unless query.empty?

    path
  end
end
