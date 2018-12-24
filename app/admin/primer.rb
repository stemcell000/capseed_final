ActiveAdmin.register Primer do

active_admin_import validate: true,
             csv_options: {col_sep: ";" },
             before_batch_import: ->(importer) {
               Primer.where(id: importer.values_at('id')).delete_all
              },
              batch_size: 1000 

permit_params :list, :of, :attributes, :on, :model, :id, :name, :sequence, :available

#Add Button to site
action_item do
  link_to "View Site", "/"
end

 show do |enzyme|
    attributes_table do
      row :id
      row :name
      row :sequence
      row :available
    end
  end

end
