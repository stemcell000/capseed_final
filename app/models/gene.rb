class Gene < ActiveRecord::Base
#pg_search
include PgSearch
  
has_many :clone_batches, :autosave => true

accepts_nested_attributes_for :clone_batches

#after_save { |gene| gene if gene.blank? }

validates :name , :presence => true

end
