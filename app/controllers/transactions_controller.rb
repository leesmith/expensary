class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.includes(:account).order(tran_date: :desc)
  end

  def destroy
    transaction = Transaction.find(params[:id])
    transaction.destroy
    redirect_to transactions_url, success: "The transaction was deleted!"
  end
end
