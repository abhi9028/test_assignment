class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.belongs_to :order, index: true
      t.belongs_to :user, index: true
      t.datetime :ordered_at
      t.decimal  :total_cost, precision: 10, scale: 2
      t.timestamps null: false
    end
    add_foreign_key :purchases, :orders
    add_foreign_key :purchases, :users
  end
end
