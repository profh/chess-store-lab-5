class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :session_id
      t.string :upc
      t.string :name
      t.string :image
      t.text :description
      t.decimal :price
      t.boolean :is_active, :default => true
      
      # carrierwave
      t.string :image

      t.timestamps
    end
    
    add_index :products, :session_id
    add_index :products, :upc
  end

  def self.down
    drop_table :products
  end
end
