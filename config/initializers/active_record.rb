class ActiveRecord::Base
  def self.ids
    self.all.collect{|s| s.id}
  end
end