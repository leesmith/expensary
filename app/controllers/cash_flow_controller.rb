class CashFlowController < ApplicationController
  def index
    @cash_flow = CashFlow.new.calculate_twelve_month_cash_flow
  end
end
