class PrimerF < Primer
  has_many :pcr_colony
  has_many :clone
  accepts_nested_attributes_for :pcr_colony
  accepts_nested_attributes_for :clone
end
