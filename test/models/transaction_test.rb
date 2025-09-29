require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  def setup
    @transaction = create(:transaction)
  end

  test "valid transaction" do
    assert @transaction.valid?
  end

  context "associations" do
    should belong_to(:account)
    should belong_to(:category).optional(true)
  end

  context "db indexes" do
    should have_db_index :account_id
    should have_db_index :tran_date
    should have_db_index :category_id
  end
end
