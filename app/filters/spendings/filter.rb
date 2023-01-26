module Spendings
  class Filter
    attr_accessor :min_amount, :max_amount, :category, :user

    def initialize(min_amount:, max_amount:, category:, user:)
      @min_amount = min_amount
      @max_amount = max_amount
      @category = category
      @user = user
    end

    def call
      @spendings = user.spendings
      filter_by_min_amount!
      filter_by_max_amount!
      filter_by_category!
      @spendings
    end

    private

    def filter_by_min_amount!
      return if min_amount.blank?

      @spendings = @spendings.where('amount >= ?', min_amount)
    end

    def filter_by_max_amount!
      return if max_amount.blank?

      @spendings = @spendings.where('amount < ?', max_amount)
    end

    def filter_by_category!
      return if category.blank?

      @spendings = @spendings.where(category: category)
    end
  end
end
