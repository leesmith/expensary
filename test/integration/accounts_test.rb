require "test_helper"

class AccountsTest < ActionDispatch::IntegrationTest
  def setup
    @account = create(:account, name: "Checking")
  end

  test "#index" do
    get accounts_url
    assert_equal 1, @controller.instance_variable_get(:@accounts).size
    assert_response :success
  end

  test "#show" do
    get account_url(@account)
    assert_not_nil @controller.instance_variable_get(:@account)
    assert_response :success
  end

  test "#create" do
    post accounts_url, params: {
      account: build(:account, name: "Credit Card").attributes
    }
    follow_redirect!
    assert_response :success
    assert_equal accounts_path, path
    assert_equal "The account was successfully added!", flash[:success]
    assert_equal "Credit Card", Account.last.name
  end

  test "#create with error" do
    post accounts_url, params: {
      account: build(:account, name: "").attributes
    }
    follow_redirect!
    assert_response :success
    assert_equal accounts_path, path
    assert_equal "The account could not be added!", flash[:error]
  end

  test "#update" do
    patch account_path(@account), params: { account: { name: "Discover Card" } }
    follow_redirect!
    @account.reload
    assert_response :success
    assert_equal account_path(@account), path
    assert_equal "The account was successfully updated!", flash[:success]
    assert_equal "Discover Card", @account.name
  end

  test "#update with error" do
    patch account_path(@account), params: { account: { name: "" } }
    follow_redirect!
    assert_response :success
    assert_equal account_path(@account), path
    assert_equal "The account could not be updated!", flash[:error]
  end
end
