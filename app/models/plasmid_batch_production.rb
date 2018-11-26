class PlasmidBatchProduction < ActiveRecord::Base
  include ActiveModel::Validations
  self.table_name = "plasmid_batches_productions"
  belongs_to :production
  belongs_to :plasmid_batch
  
  validates :volume, :presence => true
  validates_with VolumeValidator
  
  accepts_nested_attributes_for :production
  accepts_nested_attributes_for :plasmid_batch
  


end
