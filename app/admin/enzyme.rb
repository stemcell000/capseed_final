ActiveAdmin.register Enzyme do
 
 active_admin_import validate: true,
             csv_options: {col_sep: ";" },
             before_batch_import: ->(importer) {
               
               

              },
              batch_size: 1000 

permit_params :list, :of, :attributes, :on, :model, :id, :name, :category

#Add Button to site
action_item do
  link_to "View Site", "/"
end

 show do |enzyme|
    attributes_table do
      row :id
      row :name
    end
  end


end
