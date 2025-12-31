class SankeyChart
  def initialize(data)
    @data = data
  end

  def nodes
    all_group_titles + all_titles
  end

  def links
    income_links + group_expense_links + expense_links
  end

  private

  def all_group_titles
    @data.map { |t| t["group_title"] }.uniq.map { |t| { name: t } }
  end

  def all_titles
    @data.map { |t| t["title"] }.uniq.map { |t| { name: t } }
  end

  def income_links
    @data.filter { |t| t["group_title"] == "Income" }.map do |income_trans|
      { source: income_trans["title"], target: "Income", value: income_trans["total_income"].round(2) }
    end
  end

  def group_expense_links
    expense_group_titles.map do |group_title|
      { source: "Income", target: group_title, value: total_expense_for_group(group_title) }
    end
  end

  def expense_links
    @data.filter { |t| t["group_title"] != "Income" }.map do |expense_trans|
      { source: expense_trans["group_title"], target: expense_trans["title"], value: expense_trans["total_expenses"].round(2) }
    end
  end

  def expense_group_titles
    @data.map { |t| t["group_title"] }.uniq - [ "Income" ]
  end

  def total_expense_for_group(expense_group_title)
    @data.filter { |t| t["group_title"] == expense_group_title }.map { |t| t["total_expenses"] }.sum.round(2)
  end
end
