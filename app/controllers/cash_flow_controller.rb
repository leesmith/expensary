class CashFlowController < ApplicationController
  def index
    @month_range = params[:f].present? ? params[:f] : 6
    @include_savings = params[:savings] != "0"
    @cash_flow = CashFlow.new(@month_range, include_savings: @include_savings).calculate_monthly_cash_flow
  end
end
