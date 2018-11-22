class Asset < ActiveRecord::Base
  belongs_to :plasmid_batch
  belongs_to :production
  
  validates :volume, :presence => true
  
end
