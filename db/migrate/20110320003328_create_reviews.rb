class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.string :session_id
      t.integer :product_id
      t.integer :user_id
      t.text :review

      t.timestamps
    end
    
    add_index :reviews, :session_id
    add_index :reviews, :product_id
    add_index :reviews, :user_id
  end

  def self.down
    drop_table :reviews
  end
end
