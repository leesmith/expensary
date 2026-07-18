require "test_helper"

class TransactionsTest < ActionDispatch::IntegrationTest
  def setup
    @account = create(:account, name: "Checking")
  end

  test "#index" do
    create_list(:transaction, 5, account: @account)
    get transactions_url
    assert_equal 5, @controller.instance_variable_get(:@transactions).size
    assert_response :success
  end

  test "#edit_inline_category" do
    create(:category, title: "Mortgage")
    transaction = create(:transaction, account: @account)
    get edit_inline_category_transaction_url(transaction)
    assert_equal 1, @controller.instance_variable_get(:@categories).size
    assert_equal transaction, @controller.instance_variable_get(:@transaction)
  end

  test "#update" do
    transaction = create(:transaction, account: @account)
    patch transaction_path(transaction), params: { transaction: { description: "Chevron" } }
    follow_redirect!
    @account.reload
    assert_response :success
    assert_equal transactions_path, path
    assert_equal "The transaction was successfully updated!", flash[:success]
    assert_equal "Chevron", @account.transactions.first.description
  end

  test "#update with error" do
    transaction = create(:transaction, account: @account)
    patch transaction_path(transaction), params: { transaction: { description: "" } }
    follow_redirect!
    @account.reload
    assert_response :success
    assert_equal transactions_path, path
    assert_equal "The transaction could not be updated!", flash[:error]
    assert_not_nil @account.transactions.first.description
  end

  test "#destroy" do
    transaction = create(:transaction, account: @account)
    delete transaction_path(transaction)
    follow_redirect!
    @account.reload
    assert_response :success
    assert_equal transactions_path, path
    assert_equal "The transaction was successfully deleted!", flash[:success]
    assert_empty @account.transactions
  end
end
