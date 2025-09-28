class Accounts::TransactionsController < ApplicationController
  def destroy
    account = Account.find(params[:account_id])
    transaction = account.transactions.find(params[:id])
    transaction.destroy
    redirect_to account, success: "The transaction was deleted!"
  end
end
