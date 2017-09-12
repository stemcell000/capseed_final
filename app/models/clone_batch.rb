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
  
  accepts_nested_attributes_for :clone_batch_qcs, :allow_destroy => true, reject_if: :all_blank
  accepts_nested_attributes_for :clone_batch_attachments, :allow_destroy => true
  accepts_nested_attributes_for :clone_batch_as_plasmid_attachments, :allow_destroy => true
  accepts_nested_attributes_for :plasmid_batches, :allow_destroy => true
  accepts_nested_attributes_for :insert
  
  #Validations
  validates :temp_name, :presence => true#, :if => :enable_strict_validation?
  validates :name , :uniqueness => true, :if => :plasmid_validation?
  validates :name, :strand_as_plasmid, :glyc_stock_box_as_plasmid, :date_as_plasmid, :origin_as_plasmid, :type, :promoter_as_plasmid, :gene_as_plasmid, :presence => true#, :if => :enable_plasmid_validation?
  
  #pg_search
  include PgSearch
  multisearchable :against => [:name, :id, :comment, :comment_as_plasmid, :gene_as_plasmid, :temp_name]
 
  #scope pour limiter la liste affichée par l'autocomplete du formulaire de plasmid_design
  scope :plasmid_allow,-> {where.not(:strand_as_plasmid => nil)}
   
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
