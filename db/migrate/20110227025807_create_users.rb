class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :session_id
      t.string :username
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :race
      t.string :registration_key
      t.boolean :is_admin, :default => false
      t.boolean :is_active, :default => false
      t.string :changer, :default => nil

      t.timestamps
    end
    
    add_index :users, :session_id
    add_index :users, :username
    add_index :users, :registration_key
  end

  def self.down
    drop_table :users
  end
end
