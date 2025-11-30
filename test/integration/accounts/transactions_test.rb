require "test_helper"

class TransactionsTest < ActionDispatch::IntegrationTest
  def setup
    @account = create(:account, name: "Checking")
  end

  test "#create" do
    post account_transactions_url(@account), params: {
      transaction: build(:transaction).attributes
    }
    follow_redirect!
    assert_response :success
    assert_equal account_path(@account), path
    assert_equal "The transaction was successfully added!", flash[:success]
    assert_equal 1, @account.transactions.count
  end

  test "#create with error" do
    post account_transactions_url(@account), params: {
      transaction: build(:transaction, description: nil, amount: nil).attributes
    }
    follow_redirect!
    assert_response :success
    assert_equal account_path(@account), path
    assert_equal "The transaction could not be saved!", flash[:error]
    assert_empty @account.transactions
  end

  test "#update" do
    transaction = create(:transaction, account: @account)
    patch account_transaction_path(@account, transaction), params: { transaction: { description: "Chevron" } }
    follow_redirect!
    @account.reload
    assert_response :success
    assert_equal account_path(@account), path
    assert_equal "The transaction was successfully updated!", flash[:success]
    assert_equal "Chevron", @account.transactions.first.description
  end

  test "#update with error" do
    transaction = create(:transaction, account: @account)
    patch account_transaction_path(@account, transaction), params: { transaction: { description: "" } }
    follow_redirect!
    assert_response :success
    assert_equal account_path(@account), path
    assert_equal "The transaction could not be updated!", flash[:error]
    assert_not_nil @account.transactions.first.description
  end

  test "#destroy" do
    transaction = create(:transaction, account: @account)
    delete account_transaction_path(@account, transaction)
    follow_redirect!
    assert_response :success
    assert_equal account_path(@account), path
    assert_equal "The transaction was successfully deleted!", flash[:success]
    assert_empty @account.transactions
  end
end
