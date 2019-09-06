class VirusProductionsRecapProcess < ActiveRecord::Migration
  include VirusProductionsHelper
  include ApplicationHelper
  
  def change
    VirusProduction.all.each do |object|
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
                
    if object.clone_batches.empty?
      block2="No plasmid<br />"
      block3=""
      block4=""
    else
      block2="<table>"
          
     object.clone_batches.each do |cb| 
      
      block3="<tr><td> #{ cb.number } </td><td> #{ cb.name } </td><tr>"
     end
     
      block4="</table>"
    end
    date_of_prod = object.date_of_production.nil? ? "none" : object.date_of_production.strftime("%b %e, %Y")
    projects = object.production.nil? ? "none" : object.production.projects.pluck(:name).to_sentence
    user =  object.user.nil? ? "none" : object.user.full_name
    volume =  object.vol.nil? ? "none" : "#{object.vol} #{object.vol_unit.name}"
    
      unless object.sterilitytests.nil?
        last_st = object.sterilitytests.last 
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
                 
       gel_prot = object.gel_prot.nil? ? "none" : object.gel_prot
  
       block7= "<strong>Gel (Prot.): #{gel_prot} </strong> <br />"
       
       hek_result = object.hek_result 
       comment = object.comment
          unless object.hek_result.blank?
       block8 = "<strong>HEK results: </strong> #{hek_result} <br />"
       else
         block8=""
          end
          unless object.comment.blank?
           block9 = "<strong>Comment: </strong> #{comment}<br />"
        else
          block9=""
          end
           last_dosage = object.dosages.last
           inactivation_count = pluralize_without_count(object.dosages.count, 'Inactivation' , ' :')
           inactivation_dates = object.dosages.map {|dosage| dosage.inactivation.nil? ? "Unknown" : dosage.inactivation.strftime("%b %e, %Y")}.to_sentence
           
           if last_dosage
           last_inactivation_dates = last_dosage.date.nil? ? "none" : last_dosage.date.strftime("%b %e, %Y")
           last_dosage_titer =  last_dosage.titer.nil? ? "none" : "%.2e" %last_dosage.titer+"vg/ml"
           last_dosage_atcc = last_dosage.titer_atcc.nil? ? "none" : "%.2e" %last_dosage.titer_atcc+"vg/ml"
           last_dosage_to_atcc = last_dosage.titer_to_atcc.nil? ? "none" : "%.2e" %last_dosage.titer_to_atcc+"vg/ml"
           last_inactivation_dates = last_dosage.date.nil? ? "none" : last_dosage.date.strftime("%b %e, %Y")
           block10 ="<strong> #{inactivation_count} </strong> #{inactivation_dates} #{inactivation_dates} <br />
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
      object.update_columns(:recap => block)
                  
    end
    
  end
end
