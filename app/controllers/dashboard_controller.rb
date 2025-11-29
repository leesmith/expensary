class DashboardController < ApplicationController
  def index
    @date_filter = params[:f].present? ? Date.parse(params.expect(:f)) : Date.today
    @dashboard = Dashboard.new(@date_filter)
  end
end
