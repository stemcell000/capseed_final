class PlasmidBatch < ActiveRecord::Base
  belongs_to :clone_batch
  has_many :plasmid_batch_attachments, :dependent => :destroy
  has_many :plasmid_batch_qcs, :dependent => :destroy
  belongs_to :unit
  belongs_to :column
  belongs_to :row
  belongs_to :box
  belongs_to :production
  belongs_to :vol_unit
  belongs_to :format
  has_many :virus_productions

 #

  accepts_nested_attributes_for :clone_batch
  accepts_nested_attributes_for :plasmid_batch_attachments, :allow_destroy => true
  accepts_nested_attributes_for :plasmid_batch_qcs, :allow_destroy => true
  accepts_nested_attributes_for :box
  accepts_nested_attributes_for :row
  accepts_nested_attributes_for :column
  accepts_nested_attributes_for :vol_unit
  accepts_nested_attributes_for :virus_productions
  accepts_nested_attributes_for :format
  
  #validations
    validates :format, :concentration, :unit, :name, :presence => true
    validates :concentration, numericality: true
    validates :box, :presence => true, :if => :enable_strict_validation?
    validates :name, :uniqueness => {message: "This name is already taken."}
    
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

private
def enable_inventory_validation?
  self.inventory_validation == 1
end



end