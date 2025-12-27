class Trends
  def initialize(month_range)
    @month_range = month_range.to_i
  end

  def calculate_spending_by_category
    spending_sql = <<~SQL
    SELECT
      COALESCE(SUM(CASE WHEN transactions.tran_type = 0 THEN transactions.amount ELSE 0 END), 0) -
      COALESCE(SUM(CASE WHEN transactions.tran_type = 1 THEN transactions.amount ELSE 0 END), 0) AS total_expense,
      categories.title
    FROM transactions
    INNER JOIN categories ON transactions.category_id = categories.id
    WHERE categories.group_title != 'Income'
    AND transactions.tran_date >= '#{(Date.today - @month_range.months).beginning_of_month}'
    AND transactions.tran_date <= '#{Date.today.last_month.end_of_month}'
    GROUP BY categories.title
    ORDER BY categories.title DESC
    SQL
    result = Transaction.find_by_sql(spending_sql)
    result.map { |i| [ i.title, i.total_expense.round(2) ] }.to_h
  end
end
