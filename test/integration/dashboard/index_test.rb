require "test_helper"

class IndexTest < ActionDispatch::IntegrationTest
  test "display dashboard" do
    get root_url
    assert_response :success
  end
end
