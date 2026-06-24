class CategoriesController < ApplicationController
  def index
    @accounts = Account.all.order(:name)
    @categories = Category.includes(:category_rules).order(:group_title, :title)
  end

  def create
    category = Category.new(category_params)
    if category.save
      redirect_to categories_url, success: "The category was successfully added!"
    else
      redirect_to categories_url, error: "The category could not be added: #{category.errors.full_messages.first}"
    end
  end

  def update
    category = Category.find params.expect(:id)
    if category.update(category_params)
      redirect_to categories_url, success: "The category was successfully updated!"
    else
      redirect_to categories_url, error: "The category could not be updated!"
    end
  end

  def destroy
    category = Category.find params.expect(:id)
    category.destroy
    redirect_to categories_url, success: "The category was successfully deleted!"
  end

  private

  def category_params
    params.expect(category: [ :group_title, :title ])
  end
end
