class Transaction < ApplicationRecord
  enum :tran_type, { debit: 0, credit: 1 }
  belongs_to :account
end
