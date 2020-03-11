class PcrColony < ActiveRecord::Base
 has_and_belongs_to_many :clone_batches
 has_and_belongs_to_many :qc_attachments, :dependent => :destroy 
 belongs_to :user
 belongs_to :primer_f
 belongs_to :primer_r
 has_many :primers
 
 accepts_nested_attributes_for :qc_attachments, :allow_destroy => true, :reject_if => :all_blank
 accepts_nested_attributes_for :primer_f, :allow_destroy => true, :reject_if => :all_blank
 accepts_nested_attributes_for :primer_r, :allow_destroy => true, :reject_if => :all_blank
 accepts_nested_attributes_for :primers, :allow_destroy => true, :reject_if => :all_blank
 
end
