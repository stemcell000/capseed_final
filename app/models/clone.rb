class Clone < ActiveRecord::Base 
 #pg_search
 include PgSearch
 
 #Nested models relationships
 #ancienne relation avec assay (faux en plus puisque assayS ici. Je ne comprends pas comment ça a pu marcher...)
  #has_one :assays
  belongs_to :assay
  has_and_belongs_to_many :enzymes
  has_many :clone_attachments, :dependent => :destroy
  has_many :clone_batches, :dependent => :destroy
  has_many :clone_batch_qcs, :through => :clone_batches
  belongs_to :cmeth
  has_and_belongs_to_many :inserts
  
  accepts_nested_attributes_for :assay
  accepts_nested_attributes_for :enzymes
  accepts_nested_attributes_for :inserts
  accepts_nested_attributes_for :clone_attachments, :allow_destroy => true, reject_if: :all_blank
  accepts_nested_attributes_for :clone_batches, :allow_destroy => true, reject_if: :all_blank
  accepts_nested_attributes_for :clone_batch_qcs, :allow_destroy => true, reject_if: :all_blank
  accepts_nested_attributes_for :cmeth, :allow_destroy => true, reject_if: :all_blank

before_validation :downcase_name
before_save :downcase_name
  #validations
    validates :name, :bbnb, :inserts, :presence => true
    validates :bbnb, numericality: { only_integer: true }
    validates :batch_nb, :presence => true, numericality: { only_integer: true, greater_than_or_equal_to: 1}, :if => :enable_strict_validation?
    validates :bbnb, numericality: true
    validates :name, :length =>{in: 2..20, :message => "must be from 2 to 20 char. long"}
    validates :name, :format => { :with => /[a-zA-Z0-9]/, :message =>"has invalide format" }
    validates :name , :uniqueness => true
 
 #Le truc a ne PAS utiliser pour éviter les doublons: validates_uniqueness_of :name, :scope => :assay 
  
 #Montage de l'uploader pour plusieurs fichiers - la colonne clonefile de la db est du type jsonb (type spécifique à Postgres)
 #L'uploader a été généré ici pour l'upload unique d'un seul fichier:
 #mount_uploader :clonefile, ClonefileUploader
 #Pour l'upload multiple, il est utilisé plusieurs fois. Attention à la déclaration: mount_uploaderS dans ce cas.
 #mount_uploaders :clonefiles, ClonefileUploader
 #Dans ce cas, il n'est pas possible de mofifier les fichier via un update. Tous les fichiers sont remplacés par les nouveaux. C'est pour cela
 #que j'ai opté pour l'association d'une table clone_attachments (le montage de l'uplaoder ce fait dans le modèle correspondant à la nouvelle table.)
  
  
amoeba do
  enable
  include_association :enzymes
  include_association :inserts
end

private
def enable_strict_validation?
  self.strict_validation == 1
end
  
def downcase_name
  self.name = self.name.downcase if self.name.present?
end

  
end
