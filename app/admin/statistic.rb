ActiveAdmin.register Statistic do
    
  index do

       render :partial => 'assay_charts'
  end
  
   #Add Button to site
    action_item do
    link_to "View Site", "/"
  end
    
end

