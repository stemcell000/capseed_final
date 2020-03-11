class Cmeth < ActiveRecord::Base
  has_many :clones
  
  accepts_nested_attributes_for :clones
end
