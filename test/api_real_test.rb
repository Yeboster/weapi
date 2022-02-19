require "test_helper"

class ApiRealTest < Test::Unit::TestCase
  setup do
    @api = ::WeApi::Api.new
  end

  test "should get location for London" do
    location = @api.location_for("london")
    assert_equal 44_418, location
  end

  test "should get weather for London on 2020/01/01" do
    weather = @api.weather_for("london", "2020-01-01")

    assert_not_nil weather
    assert_equal "2020-01-01", weather["applicable_date"]
    assert_equal "Light Cloud", weather["weather_state_name"]
    assert_equal "lc", weather["weather_state_abbr"]
    assert_equal 6.13, weather["the_temp"]
    assert_equal 2.88, weather["min_temp"]
  end

  def test_weather_tomorrow_for_london
    weather = @api.weather_tomorrow_for("london")

    assert_not_nil(weather)
    assert_equal(Date.today.next_day.to_s, weather["applicable_date"])
  end

  def test_raining_tomorrow_at_london
    weather = @api.weather_tomorrow_for("london")
    expected_raining = weather["weather_state_name"].downcase.include?("rain")

    is_raining = @api.raining_tomorrow_at?("london")
    assert_equal(expected_raining, is_raining)
  end

  def test_weather_for_not_existing_city
    @api.weather_for("not_existing_city", "2020-01-01")
    assert(false)
  rescue ::WeApi::NoLocationFound
    assert(true)
  end
end
