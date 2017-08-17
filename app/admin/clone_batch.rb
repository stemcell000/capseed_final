ActiveAdmin.register CloneBatch do

index do
  column :id
  column :clone_id
  column :name
  column :temp_name
  column :comment
  column :qc_validation
  column :strict_validation
  column :created_at
  column :updated_at
  actions
 end


  #Add Button to site
  action_item do
    link_to "View Site", "/"
  end

end
