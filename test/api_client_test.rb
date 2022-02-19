# frozen_string_literal: true

require 'test_helper'

class ApiClientTest < Test::Unit::TestCase
  setup do
    @client = WeApi::ApiClient.new
  end

  test 'should build url' do
    # Use send since we are testing private method
    url = @client.send(:build_url, '/location/search', ['query=london'])
    assert_equal '/api/location/search?query=london', url
  end
end
