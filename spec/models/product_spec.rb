require 'rails_helper'

RSpec.describe Product, type: :model do

  let(:product) { FactoryGirl.create(:product) }

  it 'should require a name' do
    FactoryGirl.build(:product, name: '').should_not be_valid
  end

  it 'should require a description' do
    FactoryGirl.build(:product, description: '').should_not be_valid
  end

  it 'should require a price' do
    FactoryGirl.build(:product, price: '').should_not be_valid
  end

  it { should have_many(:order_items) }

end
