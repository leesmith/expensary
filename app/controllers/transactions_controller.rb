class TransactionsController < ApplicationController
  def index
    @categories = Category.order(:group_title, :title)
    @accounts = Account.order(:name)

    @transactions = Transaction.includes(:account, :category)
    if params[:category_id].present?
      @transactions = @transactions.where(category_id: params[:category_id])
    end
    if params[:account_id].present?
      @transactions = @transactions.where(account_id: params[:account_id])
    end
    @transactions = @transactions.order(tran_date: :desc)

    @pagy, @transactions = pagy(@transactions, limit: 50)
  end

  def update
    @transaction = Transaction.find(params.expect(:id))
    if @transaction.update(transaction_params)
      redirect_to transactions_url(page: referrer_page), success: "The transaction was successfully updated!"
    else
      redirect_to transactions_url(page: referrer_page), error: "The transaction could not be updated!"
    end
  end

  def destroy
    transaction = Transaction.find(params[:id])
    transaction.destroy
    redirect_to transactions_url(page: referrer_page), success: "The transaction was successfully deleted!"
  end

  def edit_inline_category
    @categories = Category.order(:group_title, :title)
    @transaction = Transaction.find(params.expect(:id))
  end

  private

  def referrer_page
    request.referrer[/page=(\d+)/, 1] if request.referrer =~ /page=/
  end

  def transaction_params
    params.expect(transaction: [ :tran_date, :description, :tran_type, :amount, :category_id ])
  end
end
