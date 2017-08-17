class Project < ActiveRecord::Base
  #Association
  has_and_belongs_to_many :assays, :dependent => :destroy, reject_if: :all_blank
  has_and_belongs_to_many :productions, :dependent => :destroy, reject_if: :all_blank
  
  accepts_nested_attributes_for :assays
  accepts_nested_attributes_for :productions
  
  #Validations
  validates :name, :presence => true
  
end
