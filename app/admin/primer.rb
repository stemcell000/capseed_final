ActiveAdmin.register Primer do

active_admin_import validate: true,
             csv_options: {col_sep: ";" },
             before_batch_import: ->(importer) {
               
               

              },
              batch_size: 1000 

permit_params :list, :of, :attributes, :on, :model, :id, :name, :sequence, :trash

#Add Button to site
action_item do
  link_to "View Site", "/"
end

 show do |enzyme|
    attributes_table do
      row :id
      row :name
      row :sequence
      row :trash
    end
  end

end
