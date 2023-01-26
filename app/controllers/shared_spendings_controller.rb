class SharedSpendingsController < ApplicationController
  def index
    @shared_spendings = current_user.shared_spendings
    @shared_spendings = filter_spendings if params[:shared_user_id].present?
    @shared_spendings = filter_shared_spending
    min_spending_amount!
    max_spending_amount!
  end

  private

  def filter_spendings
    @shared_spendings.where(user_id: params[:shared_user_id])
  end

  def min_spending_amount!
    return if params[:min_amount].blank?

    @shared_spendings = @shared_spendings.where('amount >= ?', params.require(:min_amount))
  end

  def max_spending_amount!
    return if params[:max_amount].blank?

    @shared_spendings = @shared_spendings.where('amount < ?', params.require(:max_amount))
  end

  def filter_shared_spending
    return @shared_spendings if params[:categories].blank?

    @shared_spendings.where(category: params[:categories])
  end
end
