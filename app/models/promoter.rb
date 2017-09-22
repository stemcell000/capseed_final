class Promoter < ActiveRecord::Base
  
#pg_search
include PgSearch
  
has_and_belongs_to_many :clone_batches

accepts_nested_attributes_for :clone_batches

 after_save { |promoter| promoter if promoter.blank? }
end
