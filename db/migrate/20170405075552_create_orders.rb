class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true
      t.integer :status, default: 0, null: false
      t.timestamps null: false
    end
    add_foreign_key :orders, :users
  end
end
