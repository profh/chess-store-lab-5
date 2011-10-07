class CategoriesProducts < ActiveRecord::Migration
  def self.up
    create_table :categories_products, :id => false do |t|
      t.string :session_id
      t.integer :category_id
      t.integer :product_id
    end
    
    add_index :categories_products, :session_id
    add_index :categories_products, :category_id
    add_index :categories_products, :product_id
  end

  def self.down
    drop_table :categories_products
  end
end
