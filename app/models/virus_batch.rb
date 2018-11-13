class VirusBatch < ActiveRecord::Base
  belongs_to :virus_production
  belongs_to :column
  belongs_to :row
  belongs_to :box
  belongs_to :vol_unit
  
  accepts_nested_attributes_for :virus_production
  accepts_nested_attributes_for :box
  accepts_nested_attributes_for :column
  accepts_nested_attributes_for :row
  
  def set_tube_status
    str = self.volume == 0 ? (self.trash? ? "/images/empty-med.png" : "/images/trash-med.png") : "/images/full-med.png"
    return str
  end
  
end
