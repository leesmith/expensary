class Accounts::TransactionsController < ApplicationController
  def create
    @account = Account.find params.expect(:account_id)
    transaction = @account.transactions.new(transaction_params)
    if transaction.save
      redirect_to @account, success: "The transaction was successfully created!"
    else
      redirect_to @account, error: "The transaction could not be created!"
    end
  end

  def destroy
    account = Account.find params.expect(:account_id)
    transaction = account.transactions.find(params.expect(:id))
    transaction.destroy
    redirect_to account, success: "The transaction was successfully deleted!"
  end

  private

  def transaction_params
    params.expect(transaction: [ :tran_date, :description, :tran_type, :amount, :category_id ])
  end
end
