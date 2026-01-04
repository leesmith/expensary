require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = create(:category)
  end

  test "valid category" do
    assert @category.valid?
  end

  context "associations" do
    should have_many(:transactions).dependent(:nullify)
  end

  context "validations" do
    should validate_presence_of :group_title
    should validate_presence_of :title
  end

  test "unique title for group" do
    create(:category, group_title: "Living", title: "Rent")
    dupe = build(:category, group_title: "Living", title: "Rent")
    refute dupe.valid?
    dupe = build(:category, group_title: "Bills", title: "Rent")
    assert dupe.valid?
  end
end
