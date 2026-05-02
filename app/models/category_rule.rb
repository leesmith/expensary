class CategoryRule < ApplicationRecord
  belongs_to :account, optional: true

  validates :name, presence: true
end
