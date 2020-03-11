class Primer < ActiveRecord::Base
  belongs_to :sequencing
  belongs_to :pcr_colony
  
  accepts_nested_attributes_for :sequencing
  accepts_nested_attributes_for :pcr_colony
end
