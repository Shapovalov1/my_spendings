class Spending < ApplicationRecord
  CATEGORIES = %w[Traveling Clothing Taxi Cafes Shops Other].freeze

  belongs_to :user

  validates :category, inclusion: { in: CATEGORIES }
end