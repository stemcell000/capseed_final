class VirusProduction < ActiveRecord::Base
 belongs_to :production
 belongs_to :user
 belongs_to :vol_unit
 
 accepts_nested_attributes_for :user
 accepts_nested_attributes_for :vol_unit
 
end
