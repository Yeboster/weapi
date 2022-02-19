require 'test/unit'
require_relative '../src/client'

class TestClient < Test::Unit::TestCase
  def test_build_url
    client = ApiClient.new
    # Use send since we are testing private method
    url = client.send(:build_url, '/location/search', ['query=london'])
    assert_equal '/api/location/search?query=london', url
  end
end
