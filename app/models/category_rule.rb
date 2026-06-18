class CategoryRule < ApplicationRecord
  OPERATORS = ["eq", "gte", "lte"]

  belongs_to :category
  validates :description, :amount, presence: true
  validates :amount_operator, presence: true, inclusion: { in: OPERATORS }
end
