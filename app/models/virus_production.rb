class VirusProduction < ActiveRecord::Base
 belongs_to :production
 belongs_to :user
 belongs_to :vol_unit
 has_many :clone_batches, :through => :production
 
#pg_search
include PgSearch
multisearchable :against => [ :comment, :id, :user, :clone_batches],
:if => lambda { |record| record.id > 0 }
  
 accepts_nested_attributes_for :user
 accepts_nested_attributes_for :vol_unit
 accepts_nested_attributes_for :production
 
 validates :date_order, :date_production, :plate_nb, :vol, :sterility, :plate_id, :vol_unit, :user, :presence => true
# validates :titer, :titer_atcc, :titer_to_atcc, numericality: { greater_than: 0, less_than: 1000000 }

end
