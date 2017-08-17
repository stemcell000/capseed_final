class VirusProduction < ActiveRecord::Base
  belongs_to :user
  belongs_to :plasmid_batch
  belongs_to :vol_unit
  
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :plasmid_batch
end
