class CategoryRulesController < ApplicationController

  def create
    category = Category.find params.expect(:category_id)
    category_rule = category.category_rules.new(category_rule_params)
    if category_rule.save
      redirect_to categories_url, success: "The category rule was successfully added!"
    else
      redirect_to categories_url, error: "The category rule could not be added!"
    end
  end

  def update
    category_rule = Category.find params.expect(:id)
    if category_rule.update(category_rule_params)
      redirect_to categories_url, success: "The category rule was successfully updated!"
    else
      redirect_to categories_url, error: "The category rule could not be updated!"
    end
  end

  def destroy
    category_rule = Category.find params.expect(:id)
    category_rule.destroy
    redirect_to categories_url, success: "The category rule was successfully deleted!"
  end

  private

  def category_rule_params
    params.expect(category_rule: [ :description, :amount, :amount_operator, :account_id ])
  end
end
