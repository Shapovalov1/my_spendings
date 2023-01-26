class SpendingsController < ApplicationController
  before_action :find_spending, only: %i[edit update destroy]

  def index
    @spendings = current_user.spendings
    @spendings = filter_spendings
    min_spending_amount!
    max_spending_amount!
    render :index
  end

  def new
    @user_spending = Spending.new
    render :new
  end

  def create
    @user_spending = Spending.new(**permit_params)
    if @user_spending.save
      flash[:success] = "New spending successfully added!"
      redirect_to user_spendings_url
    else
      flash.now[:error] = "Spending creation failed"
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    @user_spending.update(**permit_params)
    if @user_spending.invalid?
      flash[:error] = @user_spending.errors.full_messages.join("\n")

      redirect_to controller: :spendings, action: :edit
    else
      redirect_to controller: :spendings, action: :index
    end
  end

  def destroy
    @user_spending.destroy
    flash[:success] = "The spending was successfully destroyed."
    redirect_to user_spendings_url
  end

  private

  def permit_params
    params.require(:spending).permit(:description, :amount, :category, :user_id)
  end

  def find_spending
    @user_spending = Spending.find(params[:id])
  end

  def min_spending_amount!
    return if params[:min_amount].blank?

    @spendings = @spendings.where('amount >= ?', params.require(:min_amount))
  end

  def max_spending_amount!
    return if params[:max_amount].blank?

    @spendings = @spendings.where('amount < ?', params.require(:max_amount))
  end

  def filter_spendings
    return @spendings if params[:categories].blank?

    @spendings.where(category: params[:categories])
  end
end
