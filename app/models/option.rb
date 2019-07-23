class Option < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :clone_batches
  has_and_belongs_to_many :virus_productions
  
  accepts_nested_attributes_for :clone_batches
  accepts_nested_attributes_for :virus_productions
end
