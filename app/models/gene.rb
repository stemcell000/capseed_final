class Gene < ActiveRecord::Base

#pg_search
include PgSearch
  
belongs_to :clone_batch

accepts_nested_attributes_for :clone_batch

  validates :name, :uniqueness => {message: "Unique name, please!"}, :case_sensitive => false
  validates :name, :presence => true

end
