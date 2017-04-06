class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.belongs_to :user, index: true
      t.string   :name
      t.text     :address
      t.string   :email
      t.string   :city
      t.timestamps null: false
    end
    add_foreign_key :addresses, :users
  end
end
