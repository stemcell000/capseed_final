ActiveAdmin.register Box do
#Import csv   
 active_admin_import validate: false,
              csv_options: {col_sep: ";" },
              before_batch_import: ->(importer) {
                Box.where(id: importer.values_at('id')).delete_all
                
              },
              batch_size: 1000
              
#Add Button to site
action_item do
  link_to "View Site", "/"
end
permit_params :id, :name, :created_at
end
