require 'date'

require_relative 'client'

module WeApi
  class NoLocationFound < StandardError; end

  # Api to gather weather data
  class Api
    def initialize(client = nil)
      @client = client || ::WeApi::ApiClient.new
    end

    def location_for(city)
      locations = @client.call '/location/search/', query: ["query=#{city}"]
      locations&.first&.[]('woeid')
    end

    def weather_for(city, date)
      location = location_for city
      raise NoLocationFound unless location

      date = Date.parse(date) if date.is_a? String
      date = date.strftime('%Y/%m/%d')

      weather = @client.call "location/#{location}/#{date}/"
      # TODO: Extract multiple weather data
      weather&.first
    end

    def weather_tomorrow_for(city)
      weather_for(city, Date.today.next_day.to_s)
    end

    def raining_tomorrow_at?(city)
      weather = weather_tomorrow_for city
      weather['weather_state_name']&.downcase&.include? 'rain'
    end
  end
end
