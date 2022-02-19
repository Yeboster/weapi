require 'date'

# Api client
class WeApi
  def initialize(client)
    @client = client
  end

  def location_for(city)
    locations = @client.call '/location/search/', query: ["query=#{city}"]
    locations&.first&.[]('woeid')
  end

  def weather_for(city, date)
    location = location_for city
    return unless location

    date = Date.parse(date).strftime('%Y/%m/%d')

    weather = @client.call "location/#{location}/#{date}/"
    weather&.first
  end

  def weather_tomorrow_for(city)
    weather_for(city, Date.today.next_day.to_s)
  end
end
