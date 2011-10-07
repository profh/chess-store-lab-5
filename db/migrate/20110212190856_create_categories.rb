class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :session_id
      t.string :name
      t.string :code
      t.integer :display_order # not currently in use

      t.timestamps
    end
    
    add_index :categories, :session_id
    add_index :categories, :code
  end

  def self.down
    drop_table :categories
  end
end
