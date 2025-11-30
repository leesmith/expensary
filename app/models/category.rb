class Category < ApplicationRecord
  has_many :transactions, dependent: :nullify

  validates :group_title, :title, presence: true

  scope :income, -> { where(group_title: "Income") }
  scope :expense, -> { where.not(group_title: "Income") }
end
