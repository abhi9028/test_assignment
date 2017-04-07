require 'rails_helper'

RSpec.describe OrderItem, type: :model do

  let(:order_item) { FactoryGirl.create(:order_item) }

  it 'should require a quantity' do
    FactoryGirl.build(:order_item, quantity: '').should_not be_valid
  end

  it 'should require a unit_price' do
    FactoryGirl.build(:order_item, unit_price: order_item.unit_price).should be_valid
  end

  it 'should require a total_price' do
    FactoryGirl.build(:order_item, total_price: order_item.total_price).should be_valid
  end

  it 'verifies that the unit_price and total_price is generated' do
    expect(order_item.unit_price).not_to eql(nil)
    expect(order_item.total_price).not_to eql(nil)
  end

  describe OrderItem do
    it { should belong_to(:order) }
  end

  describe OrderItem do
    it { should belong_to(:product) }
  end

end
