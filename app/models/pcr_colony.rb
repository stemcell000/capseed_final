class PcrColony < ActiveRecord::Base
 has_many :plamsid_batch_qcs
  #
  
  accepts_nested_attributes_for :plamsid_batch_qcs
end
