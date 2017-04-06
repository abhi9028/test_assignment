class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.belongs_to :product, index: true
      t.belongs_to :order, index: true
      t.integer :quantity, default: 1
      t.decimal :unit_price, precision: 10, scale: 2
      t.decimal :total_price, precision: 10, scale: 2
      t.timestamps null: false
    end
    add_foreign_key :order_items, :products
    add_foreign_key :order_items, :orders
  end
end
