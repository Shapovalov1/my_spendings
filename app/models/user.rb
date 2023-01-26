class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :spendings, :dependent => :destroy
  has_many :spendings_users, class_name: 'SpendingsUser', foreign_key: :shared_user_id, inverse_of: :shared_user
  has_many :shared_spendings, through: :spendings_users, source: :spending
  has_many :shared_users, through: :spendings_users, source: :origin_user

  def users_to_share(spending_id)
    shared_user_ids = SpendingsUser.where(spending_id: spending_id).pluck(:shared_user_id).uniq
    User.all.where.not(id: shared_user_ids.push(id))
  end
end
