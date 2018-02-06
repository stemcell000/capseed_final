class PcrColony < ActiveRecord::Base
 has_and_belongs_to_many :clone_batches
 has_and_belongs_to_many :qc_attachments, :dependent => :destroy 
 belongs_to :user
 
 accepts_nested_attributes_for :qc_attachments, :allow_destroy => true, :reject_if => :all_blank
 
end
