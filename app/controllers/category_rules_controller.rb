class CategoryRulesController < ApplicationController
  def index
    @category_rules = CategoryRule.order(:name)
  end

  private

  def category_rule_params
    params.expect(category_rule: [ :name ])
  end
end
