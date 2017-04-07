FactoryGirl.define do
  factory :order_item do
    quantity 1
    order {FactoryGirl.create(:order)}
    product {FactoryGirl.create(:product)}
  end
end
