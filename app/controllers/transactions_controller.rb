class TransactionsController < ApplicationController
    before_action :require_user

  def new
    @account = Account.find(params[:account_id])
    @transaction = Transaction.new(timestamp: Time.now, amount: 0)
  end

  def create
    @account = Account.find(params[:account_id])
    @transaction = Transaction.new(transaction_params)
    @transaction.account_id = @account.id
    if @transaction.save
      redirect_to account_path(@account)
    else
      render :new
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
    @account = @transaction.account
  end

  def update
    @transaction = Transaction.find(params[:id])
    @account = @transaction.account
    if @transaction.update(transaction_params)
      redirect_to account_path(@account)
    else
      render 'edit'
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    redirect_to account_path(@transaction.account)
  end

  private
  def transaction_params
      params.require(:transaction).permit(:timestamp, :withholdIncrementToday, :amount, :description)
  end
end
