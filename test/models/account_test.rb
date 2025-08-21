require "test_helper"

class AccountTest < ActiveSupport::TestCase
  def setup
    @account = create(:account)
  end

  test "valid account" do
    assert @account.valid?
  end

  context "validations" do
    should validate_presence_of :name
    should define_enum_for :account_type
  end

  context "db indexes" do
    should have_db_index :account_type
  end
end
