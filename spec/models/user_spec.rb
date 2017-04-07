require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryGirl.create(:user) }

  # let(:stripe_info) { FactoryGirl.create(:stripe_info, user: user) }

  it 'has valid :user factory' do
    expect(user).to be_valid
  end

  it 'should require a email' do
    FactoryGirl.build(:user, email: '').should_not be_valid
  end

  it 'should require a email' do
    FactoryGirl.build(:user, password: '').should_not be_valid
  end

  it { should have_many(:orders) }

  # it { should have_many(:purchases) }

  # it { expect(user).to have_one :stripe_info }

  # describe '#role' do
  #   context 'user type' do
  #     let!(:user) { FactoryGirl.create(:user) }
  #     it 'should return user type' do
  #       expect(user.role).to eq('dentist')
  #     end
  #   end
  # end
end
