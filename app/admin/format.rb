ActiveAdmin.register Format do
def display_name
    self.name
  end

index do
  column :id
  column :name
  actions
 end
 
permit_params :id, :name

#Add Button to site
action_item do
  link_to "View Site", "/"
end


end
