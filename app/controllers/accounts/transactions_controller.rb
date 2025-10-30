class Accounts::TransactionsController < ApplicationController
  before_action :set_account

  def create
    transaction = @account.transactions.new(transaction_params)
    if transaction.save
      redirect_to @account, success: "The transaction was successfully created!"
    else
      redirect_to @account, error: "The transaction could not be saved!"
    end
  end

  def update
    transaction = @account.transactions.find params.expect(:id)
    if transaction.update(transaction_params)
      if params[:page].present?
        redirect_to account_url(@account, page: params[:page])
      else
        redirect_to account_url(@account)
      end
    else
      redirect_to @account, error: "The transaction could not be saved!"
    end
  end

  def destroy
    transaction = @account.transactions.find(params.expect(:id))
    transaction.destroy
    redirect_to @account, success: "The transaction was successfully deleted!"
  end

  def edit_inline_category
    @categories = Category.order(:group_title, :title)
    @transaction = @account.transactions.find(params.expect(:id))
    @page = params[:page]
  end

  private

  def set_account
    @account = Account.find params.expect(:account_id)
  end

  def transaction_params
    params.expect(transaction: [ :tran_date, :description, :tran_type, :amount, :category_id ])
  end
end
