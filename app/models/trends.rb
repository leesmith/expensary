class Trends
  def initialize(month_range)
    @month_range = month_range
  end

  def bar_chart_data
    transactions_sql = <<~SQL
      SELECT
        COALESCE(SUM(CASE WHEN transactions.tran_type = 0 THEN transactions.amount ELSE 0 END), 0) -
        COALESCE(SUM(CASE WHEN transactions.tran_type = 1 THEN transactions.amount ELSE 0 END), 0) AS total_expense,
        categories.title
      FROM transactions
      INNER JOIN categories ON transactions.category_id = categories.id
      WHERE categories.group_title != 'Income'
      AND #{ActiveRecord::Base.sanitize_sql_array([ "transactions.tran_date >= ?", start_date ])}
      AND #{ActiveRecord::Base.sanitize_sql_array([ "transactions.tran_date <= ?", end_date ])}
      GROUP BY categories.title
      ORDER BY categories.title DESC
    SQL
    result = ActiveRecord::Base.connection.execute(transactions_sql)
    result.map { |i| [ i["title"], i["total_expense"].round(2) ] }.to_h
  end

  def sankey_chart_data
    transactions_sql = <<~SQL
      SELECT
        -- Income: credits minus debits for 'Income' category group
        COALESCE(SUM(CASE
          WHEN categories.group_title = 'Income' AND transactions.tran_type = 1
          THEN transactions.amount
          WHEN categories.group_title = 'Income' AND transactions.tran_type = 0
          THEN -transactions.amount
          ELSE 0
          END), 0) AS total_income,
        -- Expenses: debits minus credits for non-'Income' category groups
        COALESCE(SUM(CASE
          WHEN categories.group_title != 'Income' AND transactions.tran_type = 0
          THEN transactions.amount
          WHEN categories.group_title != 'Income' AND transactions.tran_type = 1
          THEN -transactions.amount
          ELSE 0
          END), 0) AS total_expenses,
        categories.title, categories.group_title
      FROM transactions
      INNER JOIN categories ON transactions.category_id = categories.id
      WHERE transactions.category_id IS NOT NULL
      AND #{ActiveRecord::Base.sanitize_sql_array([ "transactions.tran_date >= ?", start_date ])}
      AND #{ActiveRecord::Base.sanitize_sql_array([ "transactions.tran_date <= ?", end_date ])}
      GROUP BY categories.group_title, categories.title
      ORDER BY categories.group_title, categories.title DESC
    SQL
    result = ActiveRecord::Base.connection.execute(transactions_sql)
  end

  private

  def start_date
    if @month_range == "y"
      Date.today.beginning_of_year
    else
      (Date.today - (@month_range.to_i).months).beginning_of_month
    end
  end

  def end_date
    if @month_range == "y"
      Date.today
    else
      Date.today.last_month.end_of_month
    end
  end
end
