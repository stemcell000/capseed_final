require 'elasticsearch/model'

class VirusProduction < ActiveRecord::Base
  
 include Elasticsearch::Model
 include Elasticsearch::Model::Callbacks
  
 belongs_to :production
 #has_many :user_virus_productions
 #has_many :users, through: :user_virus_productions
 belongs_to :user
 belongs_to :vol_unit
 has_many :clone_batches, :through => :production
 has_many :genes, :through => :clone_batches
 has_many :promoters, :through => :clone_batches
 has_many :dosages
 has_many :sterilitytests
 has_many :plasmid_batches, :through => :production
 has_many :virus_batches, -> { uniq }, :dependent => :destroy
 
 #scope :hidden_vps, lambda {|user| joins(:user_virus_productions).where('users_virus_productions.user_id = ?', user.id) }
 
 before_save :titer_to_atcc
 
#pg_search
include PgSearch
multisearchable :against => [ :comment, :id, :user, :clone_batches],
:if => lambda { |record| record.id > 0 }
  
 accepts_nested_attributes_for :user
 accepts_nested_attributes_for :vol_unit
 accepts_nested_attributes_for :production
 accepts_nested_attributes_for :dosages, :allow_destroy => true, reject_if: :all_blank
 accepts_nested_attributes_for :sterilitytests, :allow_destroy => true, reject_if: :all_blank
 accepts_nested_attributes_for :virus_batches
 
 ransacker :id do
    Arel::Nodes::SqlLiteral.new(
      "regexp_replace(to_char(\"#{table_name}\".\"id\", '999'), ' ', '', 'g')"
    )
  end
  
   ransacker :id do
    Arel::Nodes::SqlLiteral.new(
      "regexp_replace(to_char(\"#{table_name}\".\"production_id\", '999'), ' ', '', 'g')"
    )
  end
  
  ransacker :id do
    Arel::Nodes::SqlLiteral.new(
      "regexp_replace(to_char(\"#{table_name}\".\"vol\", '999D99S'), ' ', '', 'g')"
    )
  end
 
 def isInTrash?
  virus_batches.where(:volume => 0).any?
 end
 
 def self.to_csv(records= [], options = {})
  CSV.generate(options) do |csv|
    csv << column_names
    records.each do |virus_production|
      csv << virus_production.attributes.values_at(*column_names)
    end
  end
end
 
 #validations
 validates :date_of_production, :presence => true
 validates :user, :presence => true
 private
 #Calulates the value of titer_to_atcc automately
 def titer_to_atcc
   self.dosages.each do |dosage|
    (32800000000/dosage.titer_atcc.to_f)*dosage.titer.to_f
   end
 end
   
 def as_indexed_json(options={})
    as_json(
      only: [:number, :comment, :plasmid_tag, :plasmid_batch_tag, :gene_tag, :promoter_tag],
      include: {
        clone_batch: {
          only: [:name, :comment, :comment_as_plasmid, :number]
         },
        production: {
          only: [:name, :comment]
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
          fields: ['number^5', 'comment', 'plasmid_tag', 'plasmid_batch_tag', 'gene_tag', 'promoter_tag']
        }
      },
   }
   )
  end
end
 VirusProduction.__elasticsearch__.create_index! force: true
 VirusProduction.__elasticsearch__.import(force: true) # for auto sync model with elastic search