class Product < ActiveRecord::Base
  # relationships
  has_and_belongs_to_many :categories
  has_many :reviews

  # validations
  validates :session_id, :upc, :price, :name, :description, :presence => true
  validates :upc, :uniqueness => { :scope => :session_id }

  # scopes
  scope :active, where(:is_active => true)
  
  # attr
  attr_protected :session_id
  
  # class methods
  class << self
    def search(session_id, query)
      query = "%#{query}%"
      self.where(['products.session_id = ? AND products.name LIKE ? OR products.description LIKE ?', session_id, query, query])
    end
  end
  
  # instance methods
  def to_param
    "#{id}-#{self.name.parameterize}"
  end
end