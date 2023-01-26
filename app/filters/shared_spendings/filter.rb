module SharedSpendings
  class Filter
    attr_accessor :min_amount, :max_amount, :category, :user, :shared_user

    def initialize(shared_user: nil, min_amount:, max_amount:, category:, user:)
      @min_amount = min_amount
      @max_amount = max_amount
      @category = category
      @user = user
      @shared_user = shared_user
    end

    def call
      @spendings = user.shared_spendings
      filter_by_min_amount!
      filter_by_max_amount!
      filter_by_category!
      filter_by_shared_user!
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

    def filter_by_shared_user!
      return if shared_user.blank?

      @spendings = @spendings.where(user: shared_user)
    end
  end
end
