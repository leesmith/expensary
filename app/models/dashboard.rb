class Dashboard
  attr_accessor :total_income, :total_expenses, :cash_flow, :savings_rate

  def initialize(date_filter)
    @date_filter = date_filter
    @total_income = calc_total_income
    @total_expenses = calc_total_expenses
    @cash_flow = calc_cash_flow
    @savings_rate = calc_savings_rate
  end

  def calc_total_income
    total_income_sql = <<~SQL
      SELECT
        COALESCE(SUM(CASE WHEN transactions.tran_type = 1 THEN transactions.amount ELSE 0 END), 0) -
        COALESCE(SUM(CASE WHEN transactions.tran_type = 0 THEN transactions.amount ELSE 0 END), 0) AS total_income
      FROM transactions
      INNER JOIN categories ON transactions.category_id = categories.id
      WHERE categories.group_title = 'Income'
      AND transactions.tran_date >= '#{@date_filter.beginning_of_month}'
      AND transactions.tran_date <= '#{@date_filter.end_of_month}';
    SQL
    Transaction.find_by_sql(total_income_sql).first.total_income
  end

  def calc_total_expenses
    total_expense_sql = <<~SQL
      SELECT
        COALESCE(SUM(CASE WHEN transactions.tran_type = 0 THEN transactions.amount ELSE 0 END), 0) -
        COALESCE(SUM(CASE WHEN transactions.tran_type = 1 THEN transactions.amount ELSE 0 END), 0) AS total_expenses
      FROM transactions
      INNER JOIN categories ON transactions.category_id = categories.id
      WHERE categories.group_title != 'Income'
      AND transactions.tran_date >= '#{@date_filter.beginning_of_month}'
      AND transactions.tran_date <= '#{@date_filter.end_of_month}';
    SQL
    Transaction.find_by_sql(total_expense_sql).first.total_expenses
  end

  def calc_cash_flow
    @total_income - @total_expenses
  end

  def calc_savings_rate
    return 0 if @total_income < 1

    total_savings_sql = <<~SQL
      SELECT
        COALESCE(SUM(CASE WHEN transactions.tran_type = 0 THEN transactions.amount ELSE 0 END), 0) -
        COALESCE(SUM(CASE WHEN transactions.tran_type = 1 THEN transactions.amount ELSE 0 END), 0) AS total_savings
      FROM transactions
      INNER JOIN categories ON transactions.category_id = categories.id
      WHERE categories.group_title = 'Savings'
      AND transactions.tran_date >= '#{@date_filter.beginning_of_month}'
      AND transactions.tran_date <= '#{@date_filter.end_of_month}';
    SQL
    (Transaction.find_by_sql(total_savings_sql).first.total_savings / @total_income) * 100
  end
end
