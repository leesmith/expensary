module ApplicationHelper
  include Pagy::Frontend

  def word_date(date)
    date.blank? ? nil : date.in_time_zone("Central Time (US & Canada)").strftime("%b %d, %Y")
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
end
