class CloneBatch < ActiveRecord::Base
    
  #ActiveModel Dirty to track changes
  include ActiveModel::Dirty
  
  #Set to nil blank fields values (utile pour effacer le final name à l'étape CBQC - rename)
  before_save :normalize_blank_values
  
  belongs_to :clone
  has_and_belongs_to_many :productions, :join_table => "clone_batches_productions"
  has_and_belongs_to_many :sequencings, :dependent => :destroy
  has_and_belongs_to_many :pcr_colonies, :dependent => :destroy
  has_many :plasmid_batches, :dependent => :destroy
  belongs_to :target
      
  has_many :clone_batch_attachments, :dependent => :destroy
  has_many :clone_batch_as_plasmid_attachments, :dependent => :destroy
  belongs_to :type
  has_one :insert
  belongs_to :strand
  has_many :genes, :dependent => :destroy
  has_many :promoters, :dependent => :destroy
  


  def normalize_blank_values
    attributes.each do |column, value|
      self[column].present? || self[column] = nil
    end
  end
  
  accepts_nested_attributes_for :clone
  accepts_nested_attributes_for :sequencings, :allow_destroy => true, reject_if: :all_blank
  accepts_nested_attributes_for :pcr_colonies, :allow_destroy => true, reject_if: :all_blank
  accepts_nested_attributes_for :clone_batch_attachments, :allow_destroy => true
  accepts_nested_attributes_for :clone_batch_as_plasmid_attachments, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :plasmid_batches, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :insert
  accepts_nested_attributes_for :strand
  accepts_nested_attributes_for :type
  accepts_nested_attributes_for :genes, :allow_destroy => true
  accepts_nested_attributes_for :promoters, :allow_destroy => true
  accepts_nested_attributes_for :productions
  
  
  
  #Validations
  validates :temp_name, :presence => true, :if => :enable_strict_validation?
  #validates :name, :presence => true, :if => :enable_strict_validation?
  validates :name, :uniqueness => true, :if => :enable_strict_validation?, :allow_blank => true, :allow_nil => true
  validates :name, :glyc_stock_box_as_plasmid, :date_as_plasmid, :origin_as_plasmid, :strand, :type, :presence => true, :if => :enable_plasmid_validation?
  
  #pg_search
  include PgSearch
  multisearchable :against => [:name, :id, :comment_as_plasmid]
 
  #scope pour limiter la liste affichée par l'autocomplete du formulaire de plasmid_design
  scope :plasmid_allow,-> {where.not(:strand_id=> nil)}
  
  def custom_label
     "#{number} | #{name}"
  end

  private
  
  def enable_strict_validation?
    self.strict_validation == 1
  end
  
  def enable_plasmid_validation?
    self.plasmid_validation == 1
  end
  
  def pb_count
    self.plasmid_batches.count
  end
  

end