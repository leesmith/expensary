class Transaction < ApplicationRecord
  enum :tran_type, { debit: 0, credit: 1 }
  belongs_to :account
  belongs_to :category, optional: true

  validates :tran_date, :description, :tran_type, :amount, presence: true
end
