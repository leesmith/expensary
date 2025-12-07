class CashFlow
  def calculate_twelve_month_cash_flow
    cash_flow_sql = <<~SQL
    SELECT strftime('%Y-%m', transactions.tran_date) AS month,
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
        END), 0) AS total_expenses
    FROM transactions
    INNER JOIN categories ON transactions.category_id = categories.id
    WHERE transactions.tran_date >= '#{(Date.today - 12.months).beginning_of_month}'
    AND transactions.tran_date <= '#{Date.today.last_month.end_of_month}'
    AND transactions.category_id IS NOT NULL
    GROUP BY strftime('%Y-%m', transactions.tran_date)
    ORDER BY month;
    SQL
    result = Transaction.find_by_sql(cash_flow_sql)
  end
end
