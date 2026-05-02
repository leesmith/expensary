require "test_helper"

class CategoryRuleTest < ActiveSupport::TestCase
  def setup
    @category_rule = create(:category_rule)
  end

  test "valid category rule" do
    assert @category_rule.valid?
  end

  context "validations" do
    should validate_presence_of :name
  end

  context "associations" do
    should belong_to(:account).optional
  end
end
