class PcrColony < ActiveRecord::Base
 has_many :plasmid_batch_qcs #à supprimer
 has_many :clone_batch_qcs
  #
  
  accepts_nested_attributes_for :plasmid_batch_qcs #à supprimer
  accepts_nested_attributes_for :clone_batch_qcs
end
