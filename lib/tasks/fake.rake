# Task to load of month's worth of fake transactions based on Categories from db/seeds.rb
desc "Create fake data"
task fake: :environment do
  # Accounts
  checking = Account.create(name: "Checking", description: "Rewards Checking", account_type: "asset")
  savings = Account.create(name: "Savings", description: "Money Market Savings", account_type: "asset")
  visa = Account.create(name: "Visa Card", description: "VISA Credit Card", account_type: "liability")
  mc = Account.create(name: "Mastercard", description: "Mastercard", account_type: "liability")

  # Income
  Transaction.create(account_id: checking.id, category_id: Category.find_by(group_title: "Income", title: "Paycheck").id, description: "Paycheck", amount: 3250.50, tran_type: "credit", tran_date: Date.today.last_month.beginning_of_month)
  Transaction.create(account_id: checking.id, category_id: Category.find_by(group_title: "Income", title: "Paycheck").id, description: "Paycheck", amount: 3250.50, tran_type: "credit", tran_date: Date.today.last_month.beginning_of_month + 15.days)
  Transaction.create(account_id: savings.id, category_id: Category.find_by(group_title: "Income", title: "Interest").id, description: "Interest payment", amount: 24.70, tran_type: "credit", tran_date: Date.today.last_month.end_of_month)

  # Savings
  Transaction.create(account_id: checking.id, description: "Savings transfer", amount: 425.00, tran_date: Date.today.last_month.end_of_month, category_id: Category.find_by(group_title: "Savings", title: "Emergency Fund").id)

  # Bills
  Transaction.create(account_id: checking.id, description: "Mortgage", amount: 1235.45, tran_date: (Date.today.last_month.beginning_of_month + 2.days), category_id: Category.find_by(group_title: "Living", title: "Mortgage").id)
  Transaction.create(account_id: checking.id, description: "Power", amount: 115.10, tran_date: (Date.today.last_month.beginning_of_month + 6.days), category_id: Category.find_by(group_title: "Bills", title: "Power").id)
  Transaction.create(account_id: checking.id, description: "Water", amount: 45.90, tran_date: (Date.today.last_month.beginning_of_month + 4.days), category_id: Category.find_by(group_title: "Bills", title: "Water").id)
  Transaction.create(account_id: checking.id, description: "Internet", amount: 35.20, tran_date: (Date.today.last_month.beginning_of_month + 8.days), category_id: Category.find_by(group_title: "Bills", title: "Internet").id)
  Transaction.create(account_id: checking.id, description: "Gas", amount: 88.80, tran_date: (Date.today.last_month.beginning_of_month + 9.days), category_id: Category.find_by(group_title: "Bills", title: "Gas").id)
  Transaction.create(account_id: checking.id, description: "Phone", amount: 148.10, tran_date: (Date.today.last_month.beginning_of_month + 9.days), category_id: Category.find_by(group_title: "Bills", title: "Phone").id)

  # Random expenses
  ignored_category_ids = Category.where(group_title: "Income").pluck(:id) +
    Category.where(group_title: "Bills").pluck(:id) +
    Category.where(group_title: "Living", title: "Mortgage").pluck(:id) +
    Category.where(group_title: "Savings").pluck(:id)
  category_ids = Category.where.not(id: ignored_category_ids).pluck(:id)
  account_ids = Account.where.not(name: "Savings").pluck(:id)
  days_of_month = (0..Date.today.last_month.end_of_month.day-1).to_a

  total_expenses = 0
  while total_expenses < 3700
    tran_date = Date.today.last_month.beginning_of_month + days_of_month.sample.days
    amount = Random.rand(300.0).round(2)
    Transaction.create(
      account_id: account_ids.sample,
      tran_date: tran_date,
      category_id: category_ids.sample,
      amount: Random.rand(300.0).round(2),
      description: "#{Faker::Commerce.vendor} purchase: #{Faker::Commerce.product_name}"
    )
    total_expenses += amount
  end
end
