class Sterilitytest < ActiveRecord::Base
  belongs_to :virus_production
  accepts_nested_attributes_for :virus_production
end
