class Spending < ApplicationRecord
  CATEGORIES = %w[Traveling Clothing Taxi Cafes Shops Other].freeze

  belongs_to :user

  validates :description, presence: true
  validates :amount, presence: true
  validates :category, inclusion: { in: CATEGORIES }

  def self.categories_to_select
    CATEGORIES.each_with_index.map { |category, ind| [category, ind] }
  end
end