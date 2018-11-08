class Origin < ActiveRecord::Base
  has_many :clone_batches
  
  validates :name, :uniqueness => {message: "Unique name, please!"}, :case_sensitive => false
  validates :name, :presence => true
  
end
