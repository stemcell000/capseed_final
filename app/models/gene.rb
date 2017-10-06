class Gene < ActiveRecord::Base
#pg_search
include PgSearch
  
belongs_to :clone_batch

accepts_nested_attributes_for :clone_batch

#after_save { |gene| gene if gene.blank? }

validates :name , :presence => true

end
