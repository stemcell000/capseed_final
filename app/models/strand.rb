class Strand < ActiveRecord::Base
  has_many :clone_batches
end
