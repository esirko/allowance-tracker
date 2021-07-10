class IncrementorsController < ApplicationController

  before_action :require_user

  def new
    @account = Account.find(params[:account_id])
    @incrementor = Incrementor.new(effectivedate: Time.now, amountperday: 0)
  end

  def create
    @account = Account.find(params[:account_id])
    @incrementor = Incrementor.new(incrementor_params)
    @incrementor.account_id = @account.id
    if @incrementor.save
      redirect_to account_path(@account)
    else
      render :new
    end
  end

  def edit
    @incrementor = Incrementor.find(params[:id])
    @account = @incrementor.account
  end

  def update
    @incrementor = Incrementor.find(params[:id])
    @account = @incrementor.account
    if @incrementor.update(incrementor_params)
      redirect_to account_path(@account)
    else
      render 'edit'
    end
  end

  def destroy
    @incrementor = Incrementor.find(params[:id])
    @incrementor.destroy
    redirect_to account_path(@incrementor.account)
  end

  private
  def incrementor_params
      params.require(:incrementor).permit(:effectivedate, :amountperday, :description)
  end
end
