class Box < ActiveRecord::Base
  has_many :plasmid_batches
  has_many :virus_batches
  
  accepts_nested_attributes_for :plasmid_batches, :allow_destroy => true
  accepts_nested_attributes_for :virus_batches, :allow_destroy => true
end
