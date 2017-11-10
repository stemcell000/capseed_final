class Production < ActiveRecord::Base
  
  #pg_search
  include PgSearch
  multisearchable :against => [:name, :id, :step, :projects],
  :if => lambda { |record| record.id > 0 }
  
  #order
  include RankedModel
   ranks :row_order
  
  #Nested models relationships
  has_many :clone_batches, -> { uniq }
  belongs_to :vol_unit
  has_and_belongs_to_many :projects
  has_many :clone_batches
  has_many :virus_productions
  
  accepts_nested_attributes_for :projects
  accepts_nested_attributes_for :clone_batches
  accepts_nested_attributes_for :virus_productions
  
  #validations
  #validates :projects, :presence => true
  
  #TRES IMPORTANT: indispensable pour la validation du modèle imbriqué (nested) dans les formulaire non "modal"
  #validates_associated :clone_batches, :if => :enable_strict_validation?
    
  def self.count_by_step (label)
    Production.where(:step => label ).count
  end
  
  def self.get_step_label
    Production.uniq.pluck(:step)
  end
  
  def self.text_search(query)
    search(query)
  end
  
  private
  
  def enable_strict_validation?
    self.strict_validation == 1
  end
  
  
end