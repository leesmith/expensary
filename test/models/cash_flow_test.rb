require "test_helper"

class CashFlowModelTest < ActiveSupport::TestCase
  setup do
    account = create(:account)
    date = Date.today.last_month.beginning_of_month + 1.day
    create(:transaction, account: account, category: create(:category), tran_type: :debit, amount: 100, tran_date: date)
    create(:transaction, account: account, category: create(:category, group_title: "Savings", title: "Emergency"), tran_type: :debit, amount: 40, tran_date: date)
  end

  test "includes savings in expenses by default" do
    assert_equal 140, CashFlow.new(3).calculate_monthly_cash_flow.first["total_expenses"]
  end

  test "excludes savings from expenses when requested" do
    assert_equal 100, CashFlow.new(3, include_savings: false).calculate_monthly_cash_flow.first["total_expenses"]
  end
end
