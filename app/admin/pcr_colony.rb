ActiveAdmin.register PcrColony do

permit_params :list, :of, :attributes, :on, :model, :id, :name

#Add Button to site
action_item do
  link_to "View Site", "/"
end


end
