require "test_helper"

class DashboardTest < ActionDispatch::IntegrationTest
  test "#index" do
    get root_url
    assert_not_nil @controller.instance_variable_get(:@dashboard)
    assert_response :success
  end
end
