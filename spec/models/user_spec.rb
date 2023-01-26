require 'rails_helper'

RSpec.describe User do
  it 'should have many spendings' do
    t = User.reflect_on_association(:spendings)
    expect(t.macro).to eq(:has_many)
  end

  it 'should have many spendings_users' do
    t = User.reflect_on_association(:spendings_users)
    expect(t.macro).to eq(:has_many)
  end

  it 'should have many shared_spendings' do
    t = User.reflect_on_association(:shared_spendings)
    expect(t.macro).to eq(:has_many)
  end

  it 'should have many shared_users' do
    t = User.reflect_on_association(:shared_users)
    expect(t.macro).to eq(:has_many)
  end
  
  describe '#users_to_share' do
    let!(:user1) { User.create(email: 'user1@gmail.com', password: 'Qwer1234') }
    let!(:user2) { User.create(email: 'user2@gmail.com', password: 'Qwer1234') }
    let!(:user3) { User.create(email: 'user3@gmail.com', password: 'Qwer1234') }
    let!(:spending) { Spending.create(description: 'milk', amount: 42, category: 'Shops', user: user1) }
    let!(:spendings_users) { SpendingsUser.create(origin_user: user1, spending: spending, shared_user: user2)}

    it 'returns correct item' do
      expect(user1.users_to_share(spending.id).ids).to match_array([user3.id])
    end
  end
end
