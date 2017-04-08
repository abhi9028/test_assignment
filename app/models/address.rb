class Address < ActiveRecord::Base
  validates :name, :line_1, :city, :email,  presence: true
  belongs_to :order
end
