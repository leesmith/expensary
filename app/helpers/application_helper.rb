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

  def grouped_category_options(categories, selected_category_id = nil)
    optgroup = ""
    categories.map(&:group_title).uniq.each do |group|
      optgroup << "<optgroup label=\"#{group}\">"
      categories.select { |c| c.group_title == group }.each do |category|
        if selected_category_id.present? && category.id == selected_category_id
          optgroup << "<option value=\"#{category.id}\" selected=\"selected\">#{category.title}</option>"
        else
          optgroup << "<option value=\"#{category.id}\">#{category.title}</option>"
        end
      end
      optgroup << "</optgroup>"
    end
    optgroup
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
