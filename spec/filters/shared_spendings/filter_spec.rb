require 'rails_helper'

RSpec.describe SharedSpendings::Filter do
  describe '.call' do
    subject { described_class.new(input).call }

    let(:input) do
      {
        min_amount: min_amount,
        max_amount: max_amount,
        category: category,
        user: shared_user1,
        shared_user: shared_user
      }
    end
    let(:min_amount) { nil }
    let(:max_amount) { nil }
    let(:category) { nil }
    let!(:user) { User.create(email: 'user1@gmail.com', password: 'Qwer1234') }
    let!(:shared_user) { nil }
    let!(:shared_user1) { User.create(email: 'user2@gmail.com', password: 'Qwer1234') }
    let!(:spending) { Spending.create(description: 'milk', amount: 42, category: 'Shops', user: user) }
    let!(:spendings_user) { SpendingsUser.create(origin_user: user, spending: spending, shared_user: shared_user1) }

    it 'returns all spendings' do
      expect(subject.ids).to eq([spending.id])
    end

    context 'where filtering by shared_user' do
      context 'when correct spending exists' do
        let(:shared_user) { user }

        it 'returns correct spending' do
          expect(subject.ids).to eq([spending.id])
        end
      end

      context 'when correct spending does not exist' do
        let(:shared_user) { shared_user1 }

        it 'returns correct spending' do
          expect(subject.ids).to be_empty
        end
      end
    end

    context 'where filtering by min amount' do
      context 'when correct spending exists' do
        let(:min_amount) { 40 }

        it 'returns correct spending' do
          expect(subject.ids).to eq([spending.id])
        end
      end

      context 'when correct spending does not exist' do
        let(:min_amount) { 50 }

        it 'returns correct spending' do
          expect(subject.ids).to be_empty
        end
      end
    end

    context 'where filtering by max amount' do
      context 'when correct spending exists' do
        let(:max_amount) { 50 }

        it 'returns correct spending' do
          expect(subject.ids).to eq([spending.id])
        end
      end

      context 'when correct spending does not exist' do
        let(:max_amount) { 20 }

        it 'returns correct spending' do
          expect(subject.ids).to be_empty
        end
      end
    end

    context 'where filtering by category' do
      context 'when correct spending exists' do
        let(:category) { 'Shops' }

        it 'returns correct spending' do
          expect(subject.ids).to eq([spending.id])
        end
      end

      context 'when correct spending does not exist' do
        let(:category) { 'Travel' }

        it 'returns correct spending' do
          expect(subject.ids).to be_empty
        end
      end
    end
  end
end