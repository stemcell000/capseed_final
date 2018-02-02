class Promoter < ActiveRecord::Base
  
#pg_search
include PgSearch
  
belongs_to :clone_batch

accepts_nested_attributes_for :clone_batch

#validates :name , :presence => true

end
