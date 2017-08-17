class Enzyme < ActiveRecord::Base
  has_and_belongs_to_many :clones
  
   accepts_nested_attributes_for :clones
end
