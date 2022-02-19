require 'test/unit'
require_relative '../src/client'
require_relative '../src/api'

class TestApiReal < Test::Unit::TestCase
  def test_location_for_london
    client = ApiClient.new
    api = WeApi.new(client)
    location = api.location_for('london')
    assert_equal 44_418, location
  end

  def test_weather_for_london_on_2020_01_01
    client = ApiClient.new
    api = WeApi.new(client)
    weather = api.weather_for('london', '2020-01-01')

    assert_not_nil weather
    assert_equal '2020-01-01', weather['applicable_date']
    assert_equal 'Light Cloud', weather['weather_state_name']
    assert_equal 'lc', weather['weather_state_abbr']
    assert_equal 6.13, weather['the_temp']
    assert_equal 2.88, weather['min_temp']
  end

  def test_weather_tomorrow_for_london
    client = ApiClient.new
    api = WeApi.new(client)
    weather = api.weather_tomorrow_for('london')

    assert_not_nil weather
    assert_equal Date.today.next_day.to_s, weather['applicable_date']
  end

  def test_weather_for_not_existing_city
    client = ApiClient.new
    api = WeApi.new(client)
    weather = api.weather_for('not_existing_city', '2020-01-01')
    assert_nil weather
  end
end
