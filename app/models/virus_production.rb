class VirusProduction < ActiveRecord::Base
 belongs_to :production
 belongs_to :user
 belongs_to :vol_unit
 has_many :clone_batches, :through => :production
 has_many :dosages
 has_many :sterilitytests
 
 before_save :titer_to_atcc
 
#pg_search
include PgSearch
multisearchable :against => [ :comment, :id, :user, :clone_batches],
:if => lambda { |record| record.id > 0 }
  
 accepts_nested_attributes_for :user
 accepts_nested_attributes_for :vol_unit
 accepts_nested_attributes_for :production
 accepts_nested_attributes_for :dosages, :allow_destroy => true, reject_if: :all_blank
 accepts_nested_attributes_for :sterilitytests, :allow_destroy => true, reject_if: :all_blank
 
 #validates :vol, :vol_unit, :user, :date_of_production, :presence => true 
 #validates :titer, :titer_atcc, :presence => true
 
 private
 #Calulates the value of titer_to_atcc automately
   def titer_to_atcc
     self.dosages.each do |dosage|
      (32800000000/dosage.titer_atcc.to_f)*dosage.titer.to_f
     end
   end

end
