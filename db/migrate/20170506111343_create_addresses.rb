class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.belongs_to :order, index: true
      t.string   :name
      t.text     :line_1
      t.string   :city
      t.string   :email
      t.timestamps null: false
    end
    add_foreign_key :addresses, :orders
  end
end
