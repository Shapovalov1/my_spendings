class SharedUsersController < ApplicationController
  before_action :find_user, only: [:destroy]

  def index
    @shared_users = User.where(id: SpendingsUser.where(origin_user: current_user, spending_id: params[:spending_id]).pluck(:shared_user_id).uniq)
  end

  def create
    if params[:shared_user].blank?
      current_user.users_to_share(params[:spending_id]).find_each do |shared_user|
        SpendingsUser.create(origin_user: current_user, spending_id: params[:spending_id], shared_user: shared_user)
      end
    else
      SpendingsUser.create(origin_user: current_user, spending_id: params[:spending_id], shared_user_id: params[:shared_user])
    end

    redirect_to user_spending_shared_users_path
  end

  def destroy
    SpendingsUser.find_by(origin_user: current_user, spending_id: params[:spending_id], shared_user: @user).destroy
    flash[:success] = "The shared user destroyed."

    redirect_to user_spending_shared_users_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
