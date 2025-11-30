class AccountsController < ApplicationController
  def index
    @accounts = Account.order(:account_type, :name)
  end

  def show
    @account = Account.find(params[:id])
    @transactions = @account.transactions.includes(:category).order(tran_date: :desc)
    @categories = Category.order(:group_title, :title)
    @pagy, @transactions = pagy(@transactions, limit: 20)
  end

  def create
    account = Account.new(account_params)
    if account.save
      redirect_to accounts_url, success: "The account was successfully added!"
    else
      redirect_to accounts_url, error: "The account could not be added!"
    end
  end

  def update
    @account = Account.find(params[:id])
    if @account.update(account_params)
      redirect_to account_url(@account), success: "The account was successfully updated!"
    else
      redirect_to account_url(@account), error: "The account could not be updated!"
    end
  end

  private

  def account_params
    params.expect(account: [ :name, :description, :account_type ])
  end
end
