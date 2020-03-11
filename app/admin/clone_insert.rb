ActiveAdmin.register CloneInsert do
#Import csv   
 active_admin_import validate: true,
             csv_options: {col_sep: ";" },
             before_batch_import: ->(importer) {
               
               

              },
              batch_size: 1000 

permit_params :list, :of, :attributes, :on, :model, :id, :clone_id, :insert_id, :backbone_id

end
