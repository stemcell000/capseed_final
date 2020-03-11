class Origin < ActiveRecord::Base
  has_many :clone_batches
  accepts_nested_attributes_for :clone_batches
  validates :name, :uniqueness => {message: "Unique name, please!"}, :case_sensitive => false
  validates :name, :presence => true
end
