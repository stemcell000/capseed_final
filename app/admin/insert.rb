ActiveAdmin.register Insert do
index do
  column :id
  column :name
  column :number
  column :created_at
  column :updated_at
  actions
 end


  #Add Button to site
  action_item do
    link_to "View Site", "/"
  end

end
