ActiveAdmin.register Sterilitytest do
#Import csv   
 active_admin_import validate: false,
              csv_options: {col_sep: ";" },
              before_batch_import: ->(importer) {
   
                
              },
              batch_size: 1000
 
 batch_action :approve, :if => true do

end             
#Add Button to site
action_item do
  link_to "View Site", "/"
end

 index do
    selectable_column :id
    column :name
    column :created_at
    column :updated_at
    column :virus_production_id

   #actions
    actions defaults: false do |pb|
    link_to "Edit", edit_admin_plasmid_batch_path(pb)
  end
   
 end

end
