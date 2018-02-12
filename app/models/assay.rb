class Assay < ActiveRecord::Base
  
  #pg_search
  include PgSearch
  multisearchable :against => [ :name, :step, :last_step, :created_at, :id, :locked ]

  #order
  include RankedModel
  ranks :row_order
  
  #Nested models relationships
  #-> { uniq } empêche l'enregistrement de duplicats identifiés par l'id de clone, ici.
  has_many :clones, -> { uniq }, :dependent => :destroy
  has_many :clone_batches, :through => :clones
  belongs_to :user
  
  accepts_nested_attributes_for :clones
  accepts_nested_attributes_for :clone_batches
  accepts_nested_attributes_for :user
  
  #scopes
  scope :completed, -> {where(step: 'completed')} 
  scope :masked, -> {where(display: false)}
  
  def self.rebuild_pg_search_documents
    find_each { |record| record.update_pg_search_document }
  end

  def self.search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end
  
  #validations
  #validates :name, :presence => true, :case_sensitive => false
  #validates :name, :uniqueness => {message: "Unique name, please!"}
  #validates :name, :length =>{in: 2..20, :message => "must be from 2 to 20 char. long"}
  #validates :name, :format => { :with => /\A[a-zA-Z\d\s]*\z/, :message =>"has invalide format" }
  #validates :projects, :presence => true
  
  #TRES IMPORTANT: indispensable pour la validation du modèle imbriqué (nested) dans les formulaire non "modal"
  validates_associated :clones
    
  def self.count_by_step (label)
    Assay.where(:step => label ).count
  end
  
  def self.get_step_label
    Assay.uniq.pluck(:step)
  end
  
  def self.text_search(query)
    search(query)
  end
  
  def formatDateToGantt
    self.created_at.strftime("%Y, %-m, %-d")
  end
  
  def self.enable_link
    if self.locked
      self.locked
    end
  end
  
  private
  def enable_strict_validation?
    self.strict_validation == 1
  end
  
end
