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
  
  #validations
  validates :name, :volume, :vol_unit_id, :presence => true
  validates :name, :uniqueness => {message: "This name is already taken."}
  
  def set_tube_status
  str=""    
  case self.volume
  when 0
    str = self.trash? ? "/images/empty-med.png" : "/images/trash.png"
  when 0..50
    str="/images/full-med-low.png"
  when 50..100
    str="/images/full-med-low.png"
  when 100..500
    str="/images/full-med-half.png"
   when 100..500
    str="/images/full-med-high.png"
   when 500..1000
    str="/images/full-med-high.png"
  end
  return str
  end
  
end
