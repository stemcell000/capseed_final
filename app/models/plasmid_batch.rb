class PlasmidBatch < ActiveRecord::Base
 
  belongs_to :clone_batch
  belongs_to :type
  
  default_scope { order(:name) } #défini l'ordre d'affichage de pb par ex. dans les form (fiels_for)
  
  has_many :plasmid_batch_attachments, :dependent => :destroy
  has_and_belongs_to_many :plasmid_batch_qcs, :dependent => :destroy
  has_and_belongs_to_many :productions, :join_table => "plasmid_batches_productions"
  belongs_to :unit
  belongs_to :column
  belongs_to :row
  belongs_to :box
  belongs_to :production
  belongs_to :vol_unit
  belongs_to :format
  belongs_to :user
  belongs_to :virus_productions

 #

  accepts_nested_attributes_for :clone_batch
  accepts_nested_attributes_for :plasmid_batch_attachments, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :plasmid_batch_qcs, :allow_destroy => true
  accepts_nested_attributes_for :box, :allow_destroy => true
  accepts_nested_attributes_for :row, :allow_destroy => true
  accepts_nested_attributes_for :column, :allow_destroy => true
  accepts_nested_attributes_for :vol_unit, :allow_destroy => true
  accepts_nested_attributes_for :virus_productions, :allow_destroy => true
  accepts_nested_attributes_for :format, :allow_destroy => true
  accepts_nested_attributes_for :user, :allow_destroy => true
  
  #validations
  validates :name, :format_id, :user_id, :unit_id, :concentration, :volume, :vol_unit_id, :presence => true
  validates :concentration, numericality: true
  validates :name, :uniqueness => {message: "This name is already taken."}
  validate :box_validator
    
 #pg_search
 include PgSearch
 multisearchable :against => [:name, :comment, :id], :if => lambda { |record| record.id > 0 }
 
 
def without_box
  includes(:box).where(box: {plasmid_batch_id: nil})
end

def set_tube_status
  str = self.volume == 0 ? (self.trash? ? "/images/empty-med.png" : "/images/trash-med.png") : "/images/full-med.png"
  return str
end

def box_validator
  
end

end