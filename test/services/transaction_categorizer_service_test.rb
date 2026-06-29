require "test_helper"

class TransactionCategorizerServiceTest < ActiveSupport::TestCase
  def setup
    @category = create(:category)
    @account = create(:account)
    @transaction = create(:transaction, account: @account, description: "ABC Groceries Store", amount: 50.00, category: nil)
  end

  test "assigns category when description matches" do
    rule = create(:category_rule, category: @category, description: "Groceries", amount: nil)
    TransactionCategorizerService.new(@transaction).call
    assert_equal @category, @transaction.reload.category
  end

  test "matches description case-insensitively" do
    rule = create(:category_rule, category: @category, description: "groceries", amount: nil)
    TransactionCategorizerService.new(@transaction).call
    assert_equal @category, @transaction.reload.category
  end

  test "does not assign category when description does not match" do
    create(:category_rule, category: @category, description: "Fuel", amount: nil)
    TransactionCategorizerService.new(@transaction).call
    assert_nil @transaction.reload.category
  end

  test "assigns category when amount operator is eq and amount matches" do
    create(:category_rule, category: @category, description: "Groceries", amount: 50.00, amount_operator: "eq")
    TransactionCategorizerService.new(@transaction).call
    assert_equal @category, @transaction.reload.category
  end

  test "does not assign category when amount operator is eq and amount does not match" do
    create(:category_rule, category: @category, description: "Groceries", amount: 99.00, amount_operator: "eq")
    TransactionCategorizerService.new(@transaction).call
    assert_nil @transaction.reload.category
  end

  test "assigns category when amount operator is gte and transaction amount is equal" do
    create(:category_rule, category: @category, description: "Groceries", amount: 50.00, amount_operator: "gte")
    TransactionCategorizerService.new(@transaction).call
    assert_equal @category, @transaction.reload.category
  end

  test "assigns category when amount operator is gte and transaction amount is greater" do
    create(:category_rule, category: @category, description: "Groceries", amount: 25.00, amount_operator: "gte")
    TransactionCategorizerService.new(@transaction).call
    assert_equal @category, @transaction.reload.category
  end

  test "does not assign category when amount operator is gte and transaction amount is less" do
    create(:category_rule, category: @category, description: "Groceries", amount: 75.00, amount_operator: "gte")
    TransactionCategorizerService.new(@transaction).call
    assert_nil @transaction.reload.category
  end

  test "assigns category when amount operator is lte and transaction amount is equal" do
    create(:category_rule, category: @category, description: "Groceries", amount: 50.00, amount_operator: "lte")
    TransactionCategorizerService.new(@transaction).call
    assert_equal @category, @transaction.reload.category
  end

  test "assigns category when amount operator is lte and transaction amount is less" do
    create(:category_rule, category: @category, description: "Groceries", amount: 75.00, amount_operator: "lte")
    TransactionCategorizerService.new(@transaction).call
    assert_equal @category, @transaction.reload.category
  end

  test "does not assign category when amount operator is lte and transaction amount is greater" do
    create(:category_rule, category: @category, description: "Groceries", amount: 25.00, amount_operator: "lte")
    TransactionCategorizerService.new(@transaction).call
    assert_nil @transaction.reload.category
  end

  test "ignores amount check when rule has no amount" do
    create(:category_rule, category: @category, description: "Groceries", amount: nil, amount_operator: "eq")
    TransactionCategorizerService.new(@transaction).call
    assert_equal @category, @transaction.reload.category
  end

  test "assigns category when rule account matches transaction account" do
    create(:category_rule, category: @category, description: "Groceries", amount: nil, account: @account)
    TransactionCategorizerService.new(@transaction).call
    assert_equal @category, @transaction.reload.category
  end

  test "does not assign category when rule account does not match transaction account" do
    other_account = create(:account)
    create(:category_rule, category: @category, description: "Groceries", amount: nil, account: other_account)
    TransactionCategorizerService.new(@transaction).call
    assert_nil @transaction.reload.category
  end

  test "account-specific rule takes precedence over global rule" do
    global_category = create(:category, title: "Global")
    specific_category = create(:category, title: "Specific")
    create(:category_rule, category: global_category, description: "Groceries", amount: nil, account: nil)
    create(:category_rule, category: specific_category, description: "Groceries", amount: nil, account: @account)
    TransactionCategorizerService.new(@transaction).call
    assert_equal specific_category, @transaction.reload.category
  end

  test "applies global rule when no account is specified on the rule" do
    other_account = create(:account)
    transaction = create(:transaction, account: other_account, description: "ABC Groceries Store", amount: 50.00, category: nil)
    create(:category_rule, category: @category, description: "Groceries", amount: nil, account: nil)
    TransactionCategorizerService.new(transaction).call
    assert_equal @category, transaction.reload.category
  end

  test "returns nil and does not update when no rule matches" do
    result = TransactionCategorizerService.new(@transaction).call
    assert_nil result
    assert_nil @transaction.reload.category
  end
end
