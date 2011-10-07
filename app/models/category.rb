class Category < ActiveRecord::Base
  # relationships
  has_and_belongs_to_many :products
  
  # validations
  validates :session_id, :presence => true
  validates :code, :name, :presence => true, :uniqueness => { :scope => :session_id }
  
  # scopes
  scope :sorted, order(:name)

  # attr
  attr_protected :session_id

  # class methods

  # instance methods
  def to_param
    "#{id}-#{self.name.parameterize}"
  end
end