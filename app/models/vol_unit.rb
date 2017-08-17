class VolUnit < ActiveRecord::Base
  has_many :plasmid_batches
  has_many :virus_productions
  
  accepts_nested_attributes_for :plasmid_batches
end
