class PlasmidBatchQc < ActiveRecord::Base
  belongs_to :plasmid_batch
  belongs_to :sma1
  belongs_to :pcr_colony
  has_many :plasmid_batch_qc_attachments, :dependent => :destroy
  
  accepts_nested_attributes_for :plasmid_batch_qc_attachments, :allow_destroy => true
  accepts_nested_attributes_for :sma1
  accepts_nested_attributes_for :pcr_colony
  
  #validations
  validates :pcr_colony, :presence=> true
  validates :sma1, :dig_other, :itr, :primer1, :primer2, :date_send, :presence => true, if: :validation_switch?
    
  #validation d'un paramètre boolean (au choix)
  validates :conclusion, :inclusion => { in: [true, false], :message => 'You must add a conclusion!' }, if: :validation_switch?
  #validates :conclusion, exclusion: { in: [nil] }

end

private 

def validation_switch?
  
  !(pcr_colony_id == 4 )
  
end

