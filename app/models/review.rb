class Review < ActiveRecord::Base
  # relationships
  belongs_to :product
  belongs_to :user
  
  # validations
  validates :session_id, :presence => true
  validates :review, :presence => true
  
  # scopes
  
  # attr
  attr_protected :session_id, :product_id, :user_id
  
  # class methods
  
  # instance methods
end