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
