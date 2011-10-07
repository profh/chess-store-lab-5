class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :session_id
      t.integer :user_id
      t.float :sub_total
      t.float :tax
      t.float :total
      t.integer :billing_address_id
      t.integer :shipping_address_id

      t.timestamps
    end
    
    add_index :orders, :session_id
    add_index :orders, :user_id
    add_index :orders, :billing_address_id
    add_index :orders, :shipping_address_id
  end

  def self.down
    drop_table :orders
  end
end
