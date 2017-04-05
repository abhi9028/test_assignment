class Product < ActiveRecord::Base
	has_attached_file :avatar, styles: { medium: "270x200>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :name, presence: true

  def timestamp
  	created_at.strftime('%d %B %Y %H:%M:%S')
  end
end
