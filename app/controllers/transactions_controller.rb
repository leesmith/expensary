class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.includes(:account, :category).order(tran_date: :desc)
    @pagy, @transactions = pagy(@transactions, limit: 50)
  end

  def update
    @transaction = Transaction.find(params.expect(:id))
    if @transaction.update(transaction_params)
      if params[:page].present?
      redirect_to transactions_url(page: params[:page])
      else
      redirect_to transactions_url
      end
    else
      render :index, status: :unprocessable_content
    end
  end

  def destroy
    transaction = Transaction.find(params[:id])
    transaction.destroy
    redirect_to transactions_url, success: "The transaction was deleted!"
  end

  def edit_inline_category
    @transaction = Transaction.find(params.expect(:id))
    @page = params[:page]
  end

  private

  def transaction_params
    params.expect(transaction: [ :category_id ])
  end
end
