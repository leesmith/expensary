class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.includes(:account).order(tran_date: :desc)
  end
end
