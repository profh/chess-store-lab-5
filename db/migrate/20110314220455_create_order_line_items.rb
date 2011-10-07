class CreateOrderLineItems < ActiveRecord::Migration
  def self.up
    create_table :order_line_items do |t|
      t.string :session_id
      t.integer :order_id
      t.integer :product_id
      t.float :price
      t.integer :quantity

      t.timestamps
    end
    
    add_index :order_line_items, :session_id
    add_index :order_line_items, :order_id
    add_index :order_line_items, :product_id
  end

  def self.down
    drop_table :order_line_items
  end
end
