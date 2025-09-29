class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.includes(:account, :category).order(tran_date: :desc)
    @pagy, @transactions = pagy(@transactions, limit: 50)
  end

  def destroy
    transaction = Transaction.find(params[:id])
    transaction.destroy
    redirect_to transactions_url, success: "The transaction was deleted!"
  end
end
