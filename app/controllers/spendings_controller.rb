class SpendingsController < ApplicationController
  before_action :find_spending, only: %i[edit update destroy]

  def index
    @spendings = Spending.all
    render :index
  end

  def new
    @spending = Spending.new
    render :new
  end

  def create
    @spending = Spending.new(**permit_params)
    if @spending.save
      flash[:success] = "New spending successfully added!"
      redirect_to spendings_url
    else
      flash.now[:error] = "Spending creation failed"
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    @spending.update(**permit_params)
    if @spending.invalid?
      flash[:error] = @spending.errors.full_messages.join("\n")

      redirect_to controller: :spendings, action: :edit
    else
      redirect_to controller: :spendings, action: :index
    end
  end

  def destroy
    @spending.destroy
    flash[:success] = "The spending was successfully destroyed."
    redirect_to spendings_url
  end

  private

  def permit_params
    params.require(:spending).permit(:description, :amount, :category, :user_id)
  end

  def find_spending
    @spending = Spending.find(params[:id])
  end
end