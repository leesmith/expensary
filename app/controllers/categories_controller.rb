class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:group_title, :title)
  end

  def create
    category = Category.new(category_params)
    if category.save
      redirect_to categories_url, success: "The category was successfully added."
    else
      render :index, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
  end

  private

  def category_params
    params.expect(category: [ :group_title, :title ])
  end
end
