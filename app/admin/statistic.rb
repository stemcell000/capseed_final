ActiveAdmin.register Statistic do
    
   #Add Button to site
    action_item do
    link_to "View Site", "/"
  end
  
  index do
  column :id
  column :value
  column :label
  actions
 end
    
end

