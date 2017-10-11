class PlasmidBatch < ActiveRecord::Base
  belongs_to :clone_batch, :dependent => :destroy
  default_scope { order(:name) } #défini l'ordre d'affichage de pb par ex. dans les form (fiels_for)
  has_many :plasmid_batch_attachments, :dependent => :destroy
  has_many :plasmid_batch_qcs, :dependent => :destroy
  belongs_to :unit
  belongs_to :column
  belongs_to :row
  belongs_to :box
  belongs_to :production
  belongs_to :vol_unit
  belongs_to :format
  belongs_to :user
  has_many :virus_productions

 #

  accepts_nested_attributes_for :clone_batch, :allow_destroy => true
  accepts_nested_attributes_for :plasmid_batch_attachments, :allow_destroy => true
  accepts_nested_attributes_for :plasmid_batch_qcs, :allow_destroy => true
  accepts_nested_attributes_for :box, :allow_destroy => true
  accepts_nested_attributes_for :row, :allow_destroy => true
  accepts_nested_attributes_for :column, :allow_destroy => true
  accepts_nested_attributes_for :vol_unit, :allow_destroy => true
  accepts_nested_attributes_for :virus_productions, :allow_destroy => true
  accepts_nested_attributes_for :format, :allow_destroy => true
  accepts_nested_attributes_for :user, :allow_destroy => true
  
  #validations
  validates :format, :concentration, :unit, :user, :presence => true
  validates :concentration, numericality: true
  validates :box, :presence => true, :if => :enable_strict_validation?
  #validates :name, :uniqueness => {message: "This name is already taken."}
    
 #pg_search
 include PgSearch
 multisearchable :against => [:name, :comment, :id], :if => lambda { |record| record.id > 0 }
 
 
def without_box
  includes(:box).where(box: {plasmid_batch_id: nil})
end

def autocomplete_display
  "#{self.number} -> #{self.name}"
end
 
private
def enable_strict_validation?
  self.strict_validation == 1
end


end