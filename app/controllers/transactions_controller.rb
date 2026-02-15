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
    msg = "The transaction was successfully deleted!"
    if request.referrer =~ /page=/
      page = request.referrer[request.referrer =~ /page=/..-1].split("=").last
      redirect_to transactions_url(page: page), success: msg
    else
      redirect_to transactions_url, success: msg
    end
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
