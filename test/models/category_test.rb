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
end
