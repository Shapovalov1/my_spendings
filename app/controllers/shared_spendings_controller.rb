class SharedSpendingsController < ApplicationController
  def index
    @shared_spendings = SharedSpendings::Filter.new(
      shared_user: shared_user,
      min_amount: params[:min_amount],
      max_amount: params[:max_amount],
      category: params[:categories],
      user: current_user
    ).call
  end

  private

  def shared_user
    User.find(params[:shared_user_id]) if params[:shared_user_id].present?
  end
end
