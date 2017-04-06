class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string   :name
      t.text     :address
      t.string   :email
      t.decimal :total, precision: 10, scale: 2
      t.integer :status, default: 0, null: false
      t.string   :stripe_customer_token
      t.timestamps null: false
    end
  end
end
