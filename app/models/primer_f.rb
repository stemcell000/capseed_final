class PrimerF < Primer
  belongs_to :pcr_colony
  belongs_to :clone
  accepts_nested_attributes_for :pcr_colony
  accepts_nested_attributes_for :clone
end
