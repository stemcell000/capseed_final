class Production < ActiveRecord::Base
  
  before_update :set_starting_volumes
  
  scope :all_except, ->(production) { where.not(id: production) }
  scope :from_plasmid_batches, -> pb_array {joins(:plasmid_batch_productions).where(:plasmid_batches_productions => {plasmid_batch_id: pb_array})}
  
  scope :on_going,-> {where("last_step < ?", 3)}
  
  #order
  include RankedModel
   ranks :row_order, :scope => :on_going
  
  #Nested models relationships
  has_and_belongs_to_many :projects
  
  has_and_belongs_to_many :clone_batches, :join_table => "clone_batches_productions"
  has_many :virus_productions, :dependent => :delete_all
  
  has_many :plasmid_batch_productions, :dependent => :destroy
  has_many :plasmid_batches, :through => :plasmid_batch_productions
  
  accepts_nested_attributes_for :projects
  accepts_nested_attributes_for :plasmid_batches, :reject_if => :all_blank
  accepts_nested_attributes_for :plasmid_batch_productions
  #Ligne ci-dessous indispensable pour nested_form à la page "virus_production"
  accepts_nested_attributes_for :virus_productions, :allow_destroy => true, :reject_if => :all_blank
  
  # validations
   validates :projects, :presence => true
   validates :clone_batches, :presence => true
   validates_presence_of :clone_batches
   validates_associated :plasmid_batch_productions, :if => :enable_strict_validation?
   validates_associated :plasmid_batches, :if => :enable_strict_validation?
    
  
  #TRES IMPORTANT: indispensable pour la validation du modèle imbriqué (nested) dans les formulaire non "modal"
  validates_associated :clone_batches, :if => :enable_strict_validation?
  
    
  def self.count_by_step (label)
    Production.where(:step => label ).count
  end
  
  def self.get_step_label
    Production.uniq.pluck(:step)
  end
  
  def self.text_search(query)
    search(query)
  end
  
  ransacker :id do
    Arel::Nodes::SqlLiteral.new(
      "regexp_replace(to_char(\"#{table_name}\".\"id\", '99999999'), ' ', '', 'g')"
    )
  end
  
  self.primary_key = 'id'
  
  private
  
  def enable_strict_validation?
    self.last_step == 3
  end
  
  def set_starting_volumes
    self.plasmid_batch_productions.each do |pbp|
      pbp.starting_volume = pbp.plasmid_batch.volume.nil? ? 0 : pbp.plasmid_batch.volume
    end
  end
  

  
end