class CloneBatch < ActiveRecord::Base
  #pg_search
  include PgSearch
  
  belongs_to :clone
  has_many :clone_batch_qcs
  has_many :plasmid_batches, :dependent => :destroy
  has_many :clone_batch_attachments, :dependent => :destroy
  has_many :clone_batch_as_plasmid_attachments, :dependent => :destroy
  belongs_to :type
  has_one :insert
  belongs_to :strand
  has_and_belongs_to_many :promoters
  has_and_belongs_to_many :genes
  
  accepts_nested_attributes_for :clone_batch_qcs, :allow_destroy => true, reject_if: :all_blank
  accepts_nested_attributes_for :clone_batch_attachments, :allow_destroy => true
  accepts_nested_attributes_for :clone_batch_as_plasmid_attachments, :allow_destroy => true
  accepts_nested_attributes_for :plasmid_batches, :allow_destroy => true
  accepts_nested_attributes_for :insert
  accepts_nested_attributes_for :strand
  accepts_nested_attributes_for :genes, :allow_destroy => true, reject_if: :all_blank
  accepts_nested_attributes_for :promoters, :allow_destroy => true, reject_if: :all_blank
  accepts_nested_attributes_for :type
  
  #Validations
  validates :temp_name, :presence => true, :if => :enable_strict_validation?
  validates :name , :uniqueness => true
  validates :name, :glyc_stock_box_as_plasmid, :date_as_plasmid, :origin_as_plasmid, :presence => true, :if => :enable_plasmid_validation?
  validates_associated :promoters, :genes, :strand, :type, :if =>:enable_plasmid_validation?
  
  #pg_search
  include PgSearch
  multisearchable :against => [:name, :id, :comment, :comment_as_plasmid, :temp_name]
 
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
    sel.plasmid_batches.count
  end
  

  
end
