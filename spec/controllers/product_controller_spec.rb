require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "GET #index" do
    it "fetch all products" do
      product = FactoryGirl.create(:product)
      get :index, { :product => {}, :format => :js }
      expect(response.content_type).to eq "application/json"
    end
  end
end
