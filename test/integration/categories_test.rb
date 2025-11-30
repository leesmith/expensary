require "test_helper"

class CategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = create(:category, group_title: "Discretionary", title: "Shopping")
  end

  test "#index" do
    get categories_url
    assert_equal 1, @controller.instance_variable_get(:@categories).size
    assert_response :success
  end

  test "#create" do
    post categories_url, params: {
      category: build(:category, group_title: "Bills", title: "Television").attributes
    }
    follow_redirect!
    assert_response :success
    assert_equal categories_path, path
    assert_equal "The category was successfully added!", flash[:success]
    assert_equal "Bills", Category.last.group_title
    assert_equal "Television", Category.last.title
  end

  test "#create with error" do
    post categories_url, params: {
      category: build(:category, group_title: "").attributes
    }
    follow_redirect!
    assert_response :success
    assert_equal categories_path, path
    assert_equal "The category could not be added!", flash[:error]
  end

  test "#update" do
    patch category_path(@category), params: { category: { title: "Fuel" } }
    follow_redirect!
    @category.reload
    assert_response :success
    assert_equal categories_path, path
    assert_equal "The category was successfully updated!", flash[:success]
    assert_equal "Fuel", @category.title
  end

  test "#update with error" do
    patch category_path(@category), params: { category: { title: "" } }
    follow_redirect!
    assert_response :success
    assert_equal categories_path, path
    assert_equal "The category could not be updated!", flash[:error]
  end

  test "#destroy" do
    create(:transaction, category_id: @category.id)
    assert_equal 1, @category.transactions.count
    delete category_path(@category)
    follow_redirect!
    assert_response :success
    assert_equal categories_path, path
    assert_equal "The category was successfully deleted!", flash[:success]
    assert_equal 0, Category.count
    assert_nil Transaction.last.category
  end
end
