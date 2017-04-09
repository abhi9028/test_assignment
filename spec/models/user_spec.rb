require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryGirl.create(:user) }

  it 'has valid :user factory' do
    expect(user).to be_valid
  end

  it 'should require a email' do
    FactoryGirl.build(:user, email: '').should_not be_valid
  end

  it 'should require a password' do
    FactoryGirl.build(:user, password: '').should_not be_valid
  end

  it { should have_many(:orders) }

  # it { should have_many(:purchases) }

  # it { expect(user).to have_one :stripe_info }

end
