module ApplicationHelper
  def word_date(date)
    date.blank? ? nil : date.in_time_zone("Central Time (US & Canada)").strftime("%b %d, %Y")
  end

  def get_previous_month(date)
    return (Date.today.beginning_of_month - 1.month).to_s if date.blank?
    (date.beginning_of_month - 1.month).to_s
  end

  def get_next_month(date)
    return (Date.today.beginning_of_month + 1.month).to_s if date.blank?
    (date.beginning_of_month + 1.month).to_s
  end

  def trends_time_period_display(month_range)
    if month_range == "y"
      word_date(Date.today.beginning_of_year) + " - " + word_date(Date.today)
    else
      month_range = month_range.to_i
      word_date((Date.today - month_range.months).beginning_of_month) + " - " + word_date(Date.today.last_month.end_of_month)
    end
  end
end
