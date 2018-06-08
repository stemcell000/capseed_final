class VirusProduction < ActiveRecord::Base
 belongs_to :production
 belongs_to :user
 belongs_to :vol_unit
 has_many :clone_batches, :through => :production
 has_many :dosages
 
#pg_search
include PgSearch
multisearchable :against => [ :comment, :id, :user, :clone_batches],
:if => lambda { |record| record.id > 0 }
  
 accepts_nested_attributes_for :user
 accepts_nested_attributes_for :vol_unit
 accepts_nested_attributes_for :production
 accepts_nested_attributes_for :dosages, :allow_destroy => true
 
 #validates :vol, :vol_unit, :user, :date_of_production, :presence => true 
 #validates :titer, :titer_atcc, :presence => true
 


end
