class Type < ActiveRecord::Base
  has_many :clone_batches
  has_many :plasmid_batches, :through => :clone_batches
end
