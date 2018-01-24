class Production < ActiveRecord::Base
  
  #pg_search
  include PgSearch
  multisearchable :against => [:name, :id, :step, :projects],
  :if => lambda { |record| record.id > 0 }
  
  #order
  include RankedModel
   ranks :row_order
  
  #Nested models relationships
  has_and_belongs_to_many :clone_batches, :join_table => "clone_batches_productions"
  has_and_belongs_to_many :projects
  has_many :virus_productions
  
  accepts_nested_attributes_for :projects
  accepts_nested_attributes_for :clone_batches
  #Ligne ci-dessous indispensable pour nested_form à la page "virus_production"
  accepts_nested_attributes_for :virus_productions, :allow_destroy => true, reject_if: :all_blank
  
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
  
  ransacker :id do
    Arel::Nodes::SqlLiteral.new(
      "regexp_replace(to_char(\"#{table_name}\".\"id\", '99999999'), ' ', '', 'g')"
    )
  end
  
  private
  
  def enable_strict_validation?
    self.strict_validation == 1
  end
  
  
end