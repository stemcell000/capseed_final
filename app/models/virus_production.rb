
class VirusProduction < ActiveRecord::Base
 
 include VirusProductionsHelper
 include ApplicationHelper
  
 belongs_to :production
 has_and_belongs_to_many :options
 belongs_to :user
 belongs_to :vol_unit
 has_many :clone_batches, :through => :production
 has_many :genes, :through => :clone_batches
 has_many :promoters, :through => :clone_batches
 has_many :dosages
 has_many :sterilitytests
 has_many :plasmid_batches, :through => :production
 has_many :virus_batches, -> { uniq }, :dependent => :destroy
 
 
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
 accepts_nested_attributes_for :options
 
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
 
  def generate_recap
   
      block1 = "<strong>Associated plasmids: </strong>"
      block2=""
      block3=""
      block4=""
      block5=""
      block6=""
      block7=""
      block8=""
      block9=""
      block10=""
      block11=""
                
    if self.clone_batches.empty?
      block2="No plasmid<br />"
      block3=""
      block4=""
    else
      block2="<table>"
          
     self.clone_batches.each do |cb| 
      
      block3="<tr><td> #{ cb.number } - </td><td>  #{ cb.name } </td><tr>" + block3
     end
     
      block4="</table>"
    end
    date_of_prod = self.date_of_production.nil? ? "none" : self.date_of_production.strftime("%b %e, %Y")
    projects = self.production.nil? ? "none" : self.production.projects.pluck(:name).to_sentence
    user =  self.user.nil? ? "none" : self.user.full_name
    volume =  self.vol.nil? ? "none" : "#{self.vol} #{self.vol_unit.name}"
    
      unless self.sterilitytests.nil?
        last_st = self.sterilitytests.last 
                  if last_st
                    last_st_date = last_st.date.nil? ? "none" : last_st.date.strftime("%b %e, %Y")
                    sterility_result = last_st.sterility.nil? ? ">on-going" : int_to_string(last_st.sterility)
                    block5 = "#{last_st_date} <br /><strong>Last result for sterility: </strong> #{ sterility_result} <br />"
                  end
       else
                    block5=""
       end
           
      block6="<strong>Date of prod.: </strong> #{date_of_prod} <br />
             <strong>Project: </strong> #{projects} <br />
             <strong>Contact: </strong> #{user} <br />
             <strong>Volume: </strong> #{volume} <br />"
                 
       gel_prot = self.gel_prot.nil? ? "none" : self.gel_prot
  
       block7= "<strong>Gel (Prot.): #{gel_prot} </strong> <br />"
       
       hek_result = self.hek_result 
       comment = self.comment
          unless self.hek_result.blank?
       block8 = "<strong>HEK results: </strong> #{hek_result} <br />"
       else
         block8=""
          end
          unless self.comment.blank?
           block9 = "<strong>Comment: </strong> #{comment}<br />"
        else
          block9=""
          end
           last_dosage = self.dosages.last
           inactivation_count = pluralize_without_count(self.dosages.count, 'Inactivation' , ' :')
           inactivation_dates = self.dosages.map {|dosage| dosage.inactivation.nil? ? "Unknown" : dosage.inactivation.strftime("%b %e, %Y")}.to_sentence
           
           if last_dosage
           last_inactivation_dates = last_dosage.date.nil? ? "none" : last_dosage.date.strftime("%b %e, %Y")
           last_dosage_titer =  last_dosage.titer.nil? ? "none" : "%.2e" %last_dosage.titer+"vg/ml"
           last_dosage_atcc = last_dosage.titer_atcc.nil? ? "none" : "%.2e" %last_dosage.titer_atcc+"vg/ml"
           last_dosage_to_atcc = last_dosage.titer_to_atcc.nil? ? "none" : "%.2e" %last_dosage.titer_to_atcc+"vg/ml"
           last_inactivation_dates = last_dosage.date.nil? ? "none" : last_dosage.date.strftime("%b %e, %Y")
           block10 ="<strong> #{inactivation_count} </strong> #{inactivation_dates} <br />
                        <strong> Date of the last titration: </strong> #{last_inactivation_dates} <br />
                        <ul>  
                          <li><strong> Titer: </strong> #{last_dosage_titer} </li>
                          <li><strong> Titer ATCC: </strong> #{last_dosage_atcc} </li>
                          <li><strong> Titer to ATCC: </strong> #{last_dosage_to_atcc} </li>
                        </ul>"
           else

               block10 = "<strong>Titer :</strong>None<br />"                
           end

      block11 = "<div>"
      
      block = block1+block2+block3+block4+block5+block6+block7+block8+block9+block10+block11
      self.update_columns(:recap => block)
  end
 
 private
 #Calulates the value of titer_to_atcc automately
 def titer_to_atcc
   self.dosages.each do |dosage|
    (32800000000/dosage.titer_atcc.to_f)*dosage.titer.to_f
   end
 end
 
end
