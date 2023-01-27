require 'rails_helper'

RSpec.describe SharedUsersController, type: :request do
  let!(:user1) { User.create(email: 'user1@gmail.com', password: 'Qwer1234') }
  let!(:user2) { User.create(email: 'user2@gmail.com', password: 'Qwer1234') }
  let!(:user3) { User.create(email: 'user3@gmail.com', password: 'Qwer1234') }
  let!(:spending) { Spending.create(description: 'milk', amount: 42, category: 'Shops', user: user1) }
  let!(:spendings_user) { SpendingsUser.create(origin_user: user1, spending_id: spending.id, shared_user: user2) }

  describe "#create" do
    before { post "/users/#{user1.id}/spendings", params: { origin_user: user1, spending_id: spending.id, shared_user: user3} }
    specify("should created one spending") { change{ SpendingsUser.count }.from(1).to(2) }
  end

  describe "#destroy" do
    before { delete "/users/#{user1.id}/spendings/#{spending.id}/shared_users/#{spendings_user.id}" }
    specify("should delete one spending") { change{ SpendingsUser.count }.from(2).to(1) }
  end
end