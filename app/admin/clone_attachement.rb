ActiveAdmin.register CloneAttachment do

index do
  column :id
  column :attachment
  column :temp_name
  column :created_at
  column :updated_at
  actions
 end


  #Add Button to site
  action_item do
    link_to "View Site", "/"
  end

end
