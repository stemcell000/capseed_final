class PlasmidBatchProduction < ActiveRecord::Base
  
  include ActiveModel::Validations
  self.table_name = "plasmid_batches_productions"
  
  belongs_to :production
  belongs_to :plasmid_batch
  
  validates :volume, :presence => true
  validate :remaining_volume_validator
  
  private
  
  def remaining_volume_validator
    remain_v = 0
    unless self.volume.nil? || self.starting_volume.nil?
      remain_v= self.starting_volume - self.volume
    end
    if remain_v <0
      errors.add(:volume, "Prod. volume too high! Not enough material")
    end
  end
end
