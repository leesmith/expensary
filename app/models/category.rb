class Category < ApplicationRecord
  has_many :transactions, dependent: :nullify

  validates :group_title, :title, presence: true
  validates :title, presence: true,
    uniqueness: {
      scope: :group_title, message: "already exists for this group", case_sensitive: false
    }

  scope :income, -> { where(group_title: "Income") }
  scope :expense, -> { where.not(group_title: "Income") }
end
