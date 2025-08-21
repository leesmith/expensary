class Account < ApplicationRecord
  enum :account_type, { liability: 0, asset: 1 }, suffix: true

  validates :name, presence: true
end
