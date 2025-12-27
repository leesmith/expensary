class CashFlowController < ApplicationController
  def index
    @month_range = params[:f].present? ? params[:f] : 6
    @cash_flow = CashFlow.new(@month_range).calculate_monthly_cash_flow
  end
end
