class PlasmidBatch < ActiveRecord::Base
 
  belongs_to :clone_batch
  belongs_to :type
  
  default_scope { order(:name) } #défini l'ordre d'affichage de pb par ex. dans les form (fiels_for)
  
  has_many :plasmid_batch_attachments, :dependent => :destroy
  has_many :virus_productions, :through=> :productions
  has_and_belongs_to_many :plasmid_batch_qcs, :dependent => :destroy
  
  has_and_belongs_to_many :productions, :join_table => "plasmid_batches_productions"
  
  belongs_to :unit
  belongs_to :column
  belongs_to :row
  belongs_to :box, :inverse_of => :plasmid_batches
  belongs_to :vol_unit
  belongs_to :format
  belongs_to :user

 #

  accepts_nested_attributes_for :clone_batch
  accepts_nested_attributes_for :plasmid_batch_attachments, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :plasmid_batch_qcs, :allow_destroy => true
  accepts_nested_attributes_for :box, :allow_destroy => true
  accepts_nested_attributes_for :row, :allow_destroy => true
  accepts_nested_attributes_for :column, :allow_destroy => true
  accepts_nested_attributes_for :vol_unit, :allow_destroy => true
  accepts_nested_attributes_for :format, :allow_destroy => true
  accepts_nested_attributes_for :user, :allow_destroy => true
  accepts_nested_attributes_for :productions
  
  #validations
  validates :name, :format_id, :user_id, :unit_id, :concentration, :presence => true
  validates :volume, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :concentration, numericality: true
  validates :name, :uniqueness => {message: "This name is already taken."}
  validates_associated :plasmid_batch_productions
  
 #pg_search
 include PgSearch
 multisearchable :against => [:name, :comment, :id], :if => lambda { |record| record.id > 0 }
 
def without_box
  includes(:box).where(box: {plasmid_batch_id: nil})
end

def set_tube_status
  str = self.volume == 0 ? (self.trash? ? "/images/empty-med.png" : "/images/trash.png") : "/images/full-med.png"
  
  unless self.trash?
    case self.volume
      when 0
        str="/images/empty-med.png"
      when 0..50
        str="/images/full-med-very-low.png"
      when 50..100
        str="/images/full-med-low.png"
      when 100..500
        str="/images/full-med-half.png"
       when 500..1000
        str="/images/full-med-high.png"
      else
        str="/images/full-med-high.png"
     end
   else
       str = self.trash? ? "/images/trash.png":"/images/empty-med.png"
   end
  return str
end

end