class Product < ActiveRecord::Base
	has_attached_file :avatar, styles: { medium: "270x200>", thumb: "100x100>" }, default_url: "product#{Random.new.rand(8)}"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  # validates_attachment_presence :avatar
  validates_attachment_size :avatar, less_than: 5.megabytes

  validates :name, :description, :price, presence: true
  has_many :order_items, dependent: :destroy

  def timestamp
  	created_at.strftime('%d %B %Y %H:%M:%S')
  end
end
