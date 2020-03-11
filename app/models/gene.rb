class Gene < ActiveRecord::Base
  
has_and_belongs_to_many :clone_batches, :join_table => "clone_batches_genes"

accepts_nested_attributes_for :clone_batches

  validates :name, :uniqueness => {message: "Unique name, please!"}, :case_sensitive => false
  validates :name, :presence => true

end
