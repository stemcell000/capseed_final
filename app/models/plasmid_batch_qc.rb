class PlasmidBatchQc < ActiveRecord::Base
  belongs_to :user
  belongs_to :sma1
  has_many :plasmid_batch_qc_attachments, :dependent => :destroy
  belongs_to :plasmid_batch
  
  accepts_nested_attributes_for :plasmid_batch_qc_attachments, :allow_destroy => true
  accepts_nested_attributes_for :sma1
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :plasmid_batch
  
  
  #validations
  validates :sma1, :itr, :date_send, :presence => true
    
end



