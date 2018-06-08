class Dosage < ActiveRecord::Base
  belongs_to :virus_production
  belongs_to :user
  accepts_nested_attributes_for :virus_production
  accepts_nested_attributes_for :user
  
   #Calulates the value of titer_to_atcc automately
 
 def titer_to_atcc
   (32800000000/self.titer_atcc.to_f)*self.titer.to_f
 end
 
end

