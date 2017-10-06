class Promoter < ActiveRecord::Base
  
#pg_search
include PgSearch
  
belongs_to :clone_batch

accepts_nested_attributes_for :clone_batch

#after_save { |promoter| promoter if promoter.blank? }

validates :name , :presence => true
end
