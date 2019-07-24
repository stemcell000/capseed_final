require 'elasticsearch/model'

class CloneBatch < ActiveRecord::Base
  
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
  #ActiveModel Dirty to track changes
  include ActiveModel::Dirty
  
  #scopes
  scope :by_production,  ->(production_id) { joins(:productions).where(productions: { id: production_id }) }

  #Set to nil blank fields values (utile pour effacer le final name à l'étape CBQC - rename)
  before_save :normalize_blank_values
  
  belongs_to :clone
  has_and_belongs_to_many :options
  has_and_belongs_to_many :sequencings, :dependent => :destroy
  has_and_belongs_to_many :pcr_colonies, :dependent => :destroy
  has_many :plasmid_batches, -> { uniq }, :dependent => :destroy
  has_and_belongs_to_many :productions, :join_table => "clone_batches_productions"
  has_many :virus_productions, :through => :productions
  belongs_to :target
      
  has_many :clone_batch_attachments, :dependent => :destroy
  has_many :clone_batch_as_plasmid_attachments, :dependent => :destroy
  belongs_to :type
  has_one :insert, :dependent => :destroy, :autosave => true
  belongs_to :strand
  belongs_to :origin
  has_and_belongs_to_many :genes, :join_table => "clone_batches_genes"
  has_and_belongs_to_many :promoters, :join_table => "clone_batches_promoters"

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
  accepts_nested_attributes_for :genes, :allow_destroy => false, :reject_if => :all_blank
  accepts_nested_attributes_for :promoters, :allow_destroy => false, :reject_if => :all_blank
  accepts_nested_attributes_for :origin
  accepts_nested_attributes_for :options
  
  #Validations
  
  attr_accessor :skip_name_validation
  attr_accessor :skip_type_validation
  attr_accessor :skip_batch_validation
  attr_accessor :skip_strict_validation
  
  validates :temp_name, :presence => true unless :skip_strict_validation
  validates :name, presence: true, uniqueness: true unless :skip_name_validation
  validates :type, presence: true
  validates :strand, presence: true
  validates :glyc_stock_box_as_plasmid, :strand, :presence => true unless :skip_batch_validation
  validates_format_of :name, :with => /(\w|\s)/, :multiline => true unless :skip_name_validation
   
  #pg_search
  include PgSearch
  multisearchable :against => [:name, :id, :comment_as_plasmid]
 
  #scope pour limiter la liste affichée par l'autocomplete du formulaire de plasmid_design
  scope :plasmid_allow,-> {where.not(:strand_id=> nil)}
  
  def custom_label
     "#{number} | #{name}"
  end
  
  def autocomplete_display
    self.uniq
  end
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |clone_batch|
        csv << clone_batch.attributes.values_at(*column_names)
      end
    end
  end
  
  
  def as_indexed_json(options={})
    as_json(
      only: [:name, :number, :glyc_stock_box_as_plasmid, :comment, :comment_as_plasmid],
      include: {
        origin: {
          only: [:name]
        },
        type: {
          only: [:name]
        },
        promoters: {
          only: [:name]
        },
        genes: {
          only: [:name]
        },
        strand: {
          only: [:name]
        },
        target: {
          only: [:name]
        }
      }
    )
  end
  
  def self.search(query)
   __elasticsearch__.search(
   {
     query: {
        multi_match: {
          query: query,
          fields: ['name']
        }
      },
         highlight: {
          pre_tags: ['<mark>'],
          post_tags: ['</mark>'],
          fields: {
            name: {}
          }
                  },
                  
          suggest: {
          text: query,
          name: {
            term: {
              size: 1,
              field: :name
            }
          }
                  }
   }
   )
  end
  
  private
  
  def enable_strict_validation?
    self.strict_validation == 1
  end
  
  def enable_plasmid_validation?
    self.plasmid_validation == 1
  end

  def enable_inventory_validation?
    self.inventory_validation == 1
  end
  
  def pb_count
    self.plasmid_batches.count
  end
  
  enum status: {
    yes: 1,
    no: 0
  }

end
 CloneBatch.__elasticsearch__.create_index! force: true
 CloneBatch.__elasticsearch__.import(force: true) # for auto sync model with elastic search