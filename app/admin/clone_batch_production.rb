ActiveAdmin.register CloneBatchProduction do
  #Import csv   
 active_admin_import validate: true,
             csv_options: {col_sep: ";" },
             before_batch_import: ->(importer) {
               
               

              },
              batch_size: 1000 
 #Add Button to site
action_item do
  link_to "View Site", "/"
end

end
