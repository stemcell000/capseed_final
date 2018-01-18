class CloneBatchQc < ActiveRecord::Base
  has_and_belongs_to_many :clone_batches
  belongs_to :user
  has_and_belongs_to_many :qc_attachments, :dependent => :destroy
  belongs_to :pcr_colony
  belongs_to :sequencing

  accepts_nested_attributes_for :qc_attachments, :allow_destroy => true
  accepts_nested_attributes_for :user
  
  #validations
  validates :name, presence: { message: "You must select a technique." }
  validates :date_rec, :date => {:after_or_equal_to => :date_send, :message => 'must be after or equal to the date of sending.'}, :allow_blank => true
end

