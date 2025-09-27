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
  end

  context "db indexes" do
    should have_db_index :account_id
    should have_db_index :tran_date
  end
end
