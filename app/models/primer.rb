class Primer < ActiveRecord::Base
  belongs_to :sequencing
  accepts_nested_attributes_for :sequencing
end
