class Spending < ApplicationRecord
  CATEGORIES = %w[Traveling Clothing Taxi Cafes Shops Other].freeze

  belongs_to :user

  validates :description, presence: true
  validates :amount, presence: true
  validates :category, inclusion: { in: CATEGORIES }
end