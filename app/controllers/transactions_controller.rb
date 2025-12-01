class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.includes(:account, :category).order(tran_date: :desc)
    @categories = Category.order(:group_title, :title)
    @pagy, @transactions = pagy(@transactions, limit: 50)
  end

  def update
    @transaction = Transaction.find(params.expect(:id))
    if @transaction.update(transaction_params)
      msg = "The transaction was successfully updated!"
      if request.referrer =~ /page=/
        page = request.referrer[request.referrer =~ /page=/..-1].split("=").last
        redirect_to transactions_url(page: page), success: msg
      else
        redirect_to transactions_url, success: msg
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
    @categories = Category.order(:group_title, :title)
    @transaction = Transaction.find(params.expect(:id))
  end

  private

  def transaction_params
    params.expect(transaction: [ :tran_date, :description, :tran_type, :amount, :category_id ])
  end
end
