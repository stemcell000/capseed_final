class Production < ActiveRecord::Base
  
  #pg_search
  include PgSearch
  multisearchable :against => [:name, :id, :step, :projects],
  :if => lambda { |record| record.id > 0 }
  
  #order
  include RankedModel
   ranks :row_order
  
  #Nested models relationships
  has_many :plasmid_batches, -> { uniq }
  belongs_to :vol_unit
  has_and_belongs_to_many :projects
  has_many :clone_batches, :through => :plasmid_batches
  
  accepts_nested_attributes_for :plasmid_batches
  accepts_nested_attributes_for :projects
  
  
  #validations
  validates :name, :presence => true, :case_sensitive => false
  #validates :name, :uniqueness => true
  validates :name, :length =>{in: 5..20, :message => "must be from 2 to 20 char. long"}
  validates :name, :format => { :with => /\A[a-zA-Z\d\s]*\z/, :message =>"has invalide format" }
  validates :projects, :presence => true
  
  #TRES IMPORTANT: indispensable pour la validation du modèle imbriqué (nested) dans les formulaire non "modal"
  validates_associated :plasmid_batches
    
  def self.count_by_step (label)
    Production.where(:step => label ).count
  end
  
  def self.get_step_label
    Production.uniq.pluck(:step)
  end
  
  def self.text_search(query)
    search(query)
  end
  
  #Recherche par range de date (ou période)
  #def self.search(start_period, end_period)
   #return scoped unless search_start_date.present?
  #start_period = Date.parse(start_period).strftime("%Y-%m-%d")
  #end_period = Date.parse(end_period).strftime("%Y-%m-%d")
  #Production.where("created_at >= ? AND created_at <= ?", start_period, end_period)
  #end
  
end