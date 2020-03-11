class Project < ActiveRecord::Base
  #Association
  has_and_belongs_to_many :clones, :dependent => :destroy, reject_if: :all_blank, :join_table => "clones_projects"
  has_and_belongs_to_many :productions, :dependent => :destroy, reject_if: :all_blank
  
  accepts_nested_attributes_for :productions
  accepts_nested_attributes_for :clones
  
 def display_name
   "#{name}"
 end
  
  #Validations
  #validates :name, :presence => true
  
end
