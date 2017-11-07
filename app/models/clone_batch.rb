class CloneBatch < ActiveRecord::Base
    
  #ActiveModel Dirty to track changes
  include ActiveModel::Dirty
  
  belongs_to :clone
  belongs_to :production
  has_and_belongs_to_many :clone_batch_qcs, :dependent => :destroy
  has_many :plasmid_batches, :dependent => :destroy
      
  has_many :clone_batch_attachments, :dependent => :destroy
  has_many :clone_batch_as_plasmid_attachments, :dependent => :destroy
  belongs_to :type
  has_one :insert
  belongs_to :strand
  has_many :genes, :dependent => :destroy
  has_many :promoters, :dependent => :destroy
  
  accepts_nested_attributes_for :clone
  accepts_nested_attributes_for :clone_batch_qcs, :allow_destroy => true, reject_if: :all_blank
  accepts_nested_attributes_for :clone_batch_attachments, :allow_destroy => true
  accepts_nested_attributes_for :clone_batch_as_plasmid_attachments, :allow_destroy => true
  accepts_nested_attributes_for :plasmid_batches, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :insert
  accepts_nested_attributes_for :strand
  accepts_nested_attributes_for :type
  accepts_nested_attributes_for :genes, :allow_destroy => true
  accepts_nested_attributes_for :promoters, :allow_destroy => true
  accepts_nested_attributes_for :production
  
  
  
  #Validations
  validates :temp_name, :presence => true, :if => :enable_strict_validation?
  validates :name, :presence => true, :if => :enable_strict_validation?
  validates :name, :uniqueness => true, :if => :enable_strict_validation?
  validates :name, :glyc_stock_box_as_plasmid, :date_as_plasmid, :origin_as_plasmid, :strand, :type, :genes, :promoters, :presence => true, :if => :enable_plasmid_validation?
  validates_associated :genes, :promoters, :plasmid_batches, :if => :enable_plasmid_validation?
  
  #pg_search
  include PgSearch
  multisearchable :against => [:name, :id, :comment_as_plasmid]
 
  #scope pour limiter la liste affichée par l'autocomplete du formulaire de plasmid_design
  scope :plasmid_allow,-> {where.not(:strand_id=> nil)}

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