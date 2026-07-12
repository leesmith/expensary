class CategoryRule < ApplicationRecord
  OPERATORS = {
    "eq" => "Equal",
    "gte" => "Greater or equal",
    "lte" => "Less or equal"
  }

  belongs_to :category
  belongs_to :account, optional: true
  validates :description, presence: true
  validates :amount_operator, presence: true, inclusion: { in: OPERATORS.keys }
end
