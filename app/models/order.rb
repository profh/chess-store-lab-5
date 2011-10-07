class Order < ActiveRecord::Base
  # relationships
  has_many :order_line_items
  belongs_to :user
  
  # validations
  validates :session_id, :presence => true
  
  # scopes
  
  # attr
  attr_protected :session_id
  
  # class methods
  
  # instance methods
end