class Account < ApplicationRecord
  enum :account_type, { liability: 0, asset: 1 }, suffix: true

  validates :name, presence: true

  has_many :transactions, dependent: :destroy

  def latest_transaction
    self.transactions.order(tran_date: :desc).first
  end
end
