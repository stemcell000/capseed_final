class Sequencing < ActiveRecord::Base
   has_many :clone_batch_qcs
  #
  
  accepts_nested_attributes_for :clone_batch_qcs
end
