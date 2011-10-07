class MailingList < ActiveRecord::Base
  # relationships
  
  # validations
  validates :session_id, :presence => true
  
  # scopes
  
  # attr
  attr_protected :session_id
  
  # class methods
  
  # instance methods
end