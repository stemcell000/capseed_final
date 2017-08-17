class Insert < ActiveRecord::Base
 #
 belongs_to :clone_batch
 has_and_belongs_to_many :clones
 #
 accepts_nested_attributes_for :clones
 accepts_nested_attributes_for :clone_batch
 
end
