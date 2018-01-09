ActiveAdmin.register Enzyme do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

  #Import csv   
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
