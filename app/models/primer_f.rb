class PrimerF < Primer
  has_many :pcr_colony
  has_many :clones
  accepts_nested_attributes_for :pcr_colony
  accepts_nested_attributes_for :clones
end
