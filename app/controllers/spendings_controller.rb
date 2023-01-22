class SpendingsController < ApplicationController

  def new
  end

  def create
    Spending.create(**permit_params)
    redirect_to controller: :spendins, action: :index
  end
  def index
  end

  private

  def permit_params
    params.permit(:description, :amount, :category)
  end
end