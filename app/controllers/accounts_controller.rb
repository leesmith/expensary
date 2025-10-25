class AccountsController < ApplicationController
  def index
    @accounts = Account.order(:account_type, :name)
  end

  def show
    @account = Account.find(params[:id])
    @transactions = @account.transactions.includes(:category).order(tran_date: :desc)
    @categories = Category.order(:group_title, :title)
    @pagy, @transactions = pagy(@transactions, limit: 50)
  end

  def create
    account = Account.new(account_params)
    if account.save
      redirect_to accounts_url, success: "The account was successfully added."
    else
      render :index, status: :unprocessable_content
    end
  end

  def update
  end

  private

  def account_params
    params.expect(account: [ :name, :description, :account_type ])
  end
end
