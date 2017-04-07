require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { FactoryGirl.create(:order) }

  it 'should require a status' do
    FactoryGirl.build(:order, status: order.status).should be_valid
  end

  describe Order do
    it { should belong_to(:user) }
  end

  it { should have_many(:order_items) }

  it { expect(order).to have_one :purchase }

end
