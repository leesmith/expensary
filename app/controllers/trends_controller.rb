class TrendsController < ApplicationController
  def index
    @month_range = params[:f].present? ? params[:f] : 1
    @trends = Trends.new(@month_range).calculate_spending_by_category
  end
end
