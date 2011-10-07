class OrderLineItem < ActiveRecord::Base
  # relationships
  belongs_to :order
  
  # validations
  validates :session_id, :presence => true
  
  # scopes
  
  # attr  
  attr_protected :session_id
  
  # class methods
  
  # instance methods
end