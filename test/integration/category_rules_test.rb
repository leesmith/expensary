require "test_helper"

class CategoryRulesTest < ActionDispatch::IntegrationTest
  def setup
    @category = create(:category, group_title: "Discretionary", title: "Shopping")
    @category_rule = create(:category_rule, category: @category)
  end

  test "#create" do
    post category_category_rules_url(@category), params: {
      category_rule: build(:category_rule, description: "Acme", amount: 50.0).attributes
    }
    follow_redirect!
    assert_response :success
    assert_equal categories_path, path
    assert_equal "The category rule was successfully added!", flash[:success]
    assert_equal "Acme", CategoryRule.last.description
    assert_equal 50.0, CategoryRule.last.amount
  end

  test "#create with error" do
    post category_category_rules_url(@category), params: {
      category_rule: build(:category_rule, description: "").attributes
    }
    follow_redirect!
    assert_response :success
    assert_equal categories_path, path
    assert_equal "The category rule could not be added!", flash[:error]
  end

  test "#update" do
    patch category_category_rule_path(@category, @category_rule), params: { category_rule: { description: "Fuel" } }
    follow_redirect!
    @category_rule.reload
    assert_response :success
    assert_equal categories_path, path
    assert_equal "The category rule was successfully updated!", flash[:success]
    assert_equal "Fuel", @category_rule.description
  end

  test "#update with error" do
    patch category_category_rule_path(@category, @category_rule), params: { category_rule: { description: "" } }
    follow_redirect!
    assert_response :success
    assert_equal categories_path, path
    assert_equal "The category rule could not be updated!", flash[:error]
  end

  test "#destroy" do
    delete category_category_rule_path(@category, @category_rule)
    follow_redirect!
    assert_response :success
    assert_equal categories_path, path
    assert_equal "The category rule was successfully deleted!", flash[:success]
    assert_equal 0, CategoryRule.count
    assert_equal 0, @category.category_rules.count
  end
end
