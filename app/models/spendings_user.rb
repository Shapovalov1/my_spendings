class SpendingsUser < ApplicationRecord
  belongs_to :origin_user, class_name: 'User', foreign_key: :origin_user_id
  belongs_to :spending
  belongs_to :shared_user, class_name: 'User', foreign_key: :shared_user_id, inverse_of: :spendings_users
end