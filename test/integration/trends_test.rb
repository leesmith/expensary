require "test_helper"

class TrendsTest < ActionDispatch::IntegrationTest
  test "#index" do
    get trends_url
    assert_not_nil @controller.instance_variable_get(:@trends)
    assert_response :success
  end
end
