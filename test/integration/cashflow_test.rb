require "test_helper"

class CashFlowTest < ActionDispatch::IntegrationTest
  test "#index" do
    get cash_flow_url
    assert_not_nil @controller.instance_variable_get(:@cash_flow)
    assert_response :success
  end
end
