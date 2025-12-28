class TrendsController < ApplicationController
  def index
    @month_range = params[:f].present? ? params[:f] : 1
    if params[:g].blank? || params[:g] == "b"
      @trends = Trends.new(@month_range).bar_chart_data
    else
      @sankey_chart = SankeyChart.new(Trends.new(@month_range).sankey_chart_data)
    end
  end
end
