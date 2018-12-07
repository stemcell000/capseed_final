class Target < ActiveRecord::Base
  has_many :clone_batches
  accepts_nested_attributes_for :clone_batches
end
