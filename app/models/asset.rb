class Asset < ActiveRecord::Base
  belongs_to :plasmid_batch
  belongs_to :vol_unit
  belongs_to :production
  
  validates :volume, :vol_unit, :presence => true
  
  accepts_nested_attributes_for :vol_unit
end
