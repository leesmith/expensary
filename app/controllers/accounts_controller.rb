class AccountsController < ApplicationController
  def index
    @accounts = Account.all
  end

  def create
    account = Account.new(account_params)
    if account.save
      redirect_to accounts_url, success: "The account was successfully added."
    else
      render :index, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
  end

  private

  def account_params
    params.expect(account: [ :name, :description, :account_type ])
  end
end
