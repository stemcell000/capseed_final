class PlasmidBatchQc < ActiveRecord::Base
  belongs_to :user
  belongs_to :sma1
  has_many :plasmid_batch_qc_attachments, :dependent => :destroy
  has_and_belongs_to_many :plasmid_batches
  
  accepts_nested_attributes_for :plasmid_batch_qc_attachments, :allow_destroy => true
  accepts_nested_attributes_for :sma1
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :plasmid_batches
  
  
  #validations
  validates :sma1, :date_send, :user, :presence => true
    
end



