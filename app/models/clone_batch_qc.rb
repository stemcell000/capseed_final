class CloneBatchQc < ActiveRecord::Base
  belongs_to :clone_batch
  belongs_to :user
  has_many :clone_batch_qc_attachments, :dependent => :destroy
  
  accepts_nested_attributes_for :clone_batch_qc_attachments, :allow_destroy => true
  accepts_nested_attributes_for :user
  
  #validations
  validates :primer_nb, :primer_name, :date_rec, :date_send, :presence => true
  #validation d'un paramètre boolean (au choix)
  validates :conclusion, :inclusion => { in: [true, false], :message => 'You must conclude!' }
  #validates :conclusion, exclusion: { in: [nil] }
  validates :user, :presence => true
  
  validates :date_rec, :date => {:after_or_equal_to => :date_send, :message => 'must be after or equal to the date of sending.'}
  validates :primer_nb, numericality: { only_integer: true }
  
end

