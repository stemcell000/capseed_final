class Gene < ActiveRecord::Base
  has_many :clone_batches
end
