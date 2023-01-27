require 'rails_helper'

RSpec.describe SpendingsController, type: :request do
  let!(:user1) { User.create(email: 'user1@gmail.com', password: 'Qwer1234') }
  let!(:spending) { Spending.create(description: 'milk', amount: 42, category: 'Shops', user: user1) }

  describe "#create" do
    before { post "/users/#{user1.id}/spendings", params: { description: "dinner", amount: 2, category: 'Cafes'} }
    specify("should created one spending") { change{ Spending.count }.from(1).to(2) }
  end

  describe "#update" do
    before { patch "/users/#{user1.id}/spendings/#{spending.id}", params: { description: "milk", amount: 2, category: 'Shops'} }
    specify("should update amount") { change{ spending.amount }.from(42).to(2) }
  end

  describe "#destroy" do
    before { delete "/users/#{user1.id}/spendings/#{spending.id}" }
    specify("should delete one spending") { change{ Spending.count }.from(2).to(1) }
  end
end