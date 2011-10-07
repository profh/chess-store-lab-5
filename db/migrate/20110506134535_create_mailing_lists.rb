class CreateMailingLists < ActiveRecord::Migration
  def self.up
    create_table :mailing_lists do |t|
      t.string :session_id
      t.string :email

      t.timestamps
    end
    
    add_index :mailing_lists, :session_id
    add_index :mailing_lists, :email
  end

  def self.down
    drop_table :mailing_lists
  end
end
