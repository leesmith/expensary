class DashboardController < ApplicationController
  def index
    @date_filter = params[:f].present? ? Date.parse(params.expect(:f)) : Date.today

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
    @total_income = Transaction.find_by_sql(total_income_sql).first.total_income

    total_expense_sql = <<~SQL
      SELECT
        COALESCE(SUM(CASE WHEN transactions.tran_type = 1 THEN transactions.amount ELSE 0 END), 0) -
        COALESCE(SUM(CASE WHEN transactions.tran_type = 0 THEN transactions.amount ELSE 0 END), 0) AS total_expenses
      FROM transactions
      INNER JOIN categories ON transactions.category_id = categories.id
      WHERE categories.group_title != 'Income'
      AND transactions.tran_date >= '#{@date_filter.beginning_of_month}'
      AND transactions.tran_date < '#{@date_filter.end_of_month}';
    SQL
    @total_expenses = Transaction.find_by_sql(total_expense_sql).first.total_expenses.abs

    @total_net_income = @total_income - @total_expenses
  end
end
