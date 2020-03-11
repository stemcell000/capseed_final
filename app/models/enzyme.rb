class Enzyme < ActiveRecord::Base
  has_and_belongs_to_many :clones
  
  accepts_nested_attributes_for :clones
   
  validates :name, :presence => true, :case_sensitive => false
  validates :name, :uniqueness => {message: "This enzyme already exists in the inventory."}
  
  def dependencies
    self.clones.empty?
  end
end
