module ApplicationHelper
  include Pagy::Frontend

  def word_date(date)
    date.blank? ? nil : date.in_time_zone("Central Time (US & Canada)").strftime("%b %d, %Y")
  end
end
