# frozen_string_literal: true

require_relative 'weapi/client'
require_relative 'weapi/api'

require 'date'
require 'thor'

# TODO: Add tests for the CLI

# A console line interface to gather weather data using MetaWeather API
class WeApiCLI < Thor
  def initialize(*args)
    super(*args)
    @api = WeApi::Api.new
  end

  desc 'raining-tomorrow-in CITY', 'Check if tomorrow is raining in CITY'
  def raining_tomorrow_in(city)
    answer = @api.raining_tomorrow_in?(city) ? 'Yes' : 'No'
    puts("#{answer}, it's #{answer == 'No' ? 'not ' : ''}raining tomorrow in #{city}")
  rescue WeApi::NoLocationFound
    puts("City '#{city}' not found")
  end

  desc 'weather-on DATE CITY', 'Get weather for a CITY on given DATE'
  def weather_on(date, city)
    begin
      date = Date.parse(date)
    rescue Date::Error
      puts('Invalid date')
    end

    if (weather = @api.weather_for(city, date))
      show_weather(weather, city)
    else
      puts("No weather for #{city} on #{date}")
    end
  rescue WeApi::NoLocationFound
    puts("City '#{city}' not found")
  end

  desc 'weather-tomorrow-in CITY', "Get tomorrow's weather for a CITY"
  def weather_tomorrow_in(city)
    if (weather = @api.weather_tomorrow_for(city))
      show_weather(weather, city)
    else
      puts("No weather for #{city} tomorrow")
    end
  rescue WeApi::NoLocationFound
    puts("City '#{city}' not found")
  end

  private

  def show_weather(weather, city)
    puts('No weather found') unless weather

    puts("Weather for #{city} on #{weather['applicable_date']}")
    puts('----------------------------')
    puts("Weather: #{weather['weather_state_name']}")
    puts("Wind direction: #{weather['wind_direction_compass']}")
    puts("Wind speed: #{weather['wind_speed'].round(2)}")
    puts("Prediction accuracy: #{weather['predictability']}%")
  end
end
