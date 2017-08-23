ActiveAdmin.register Clone do
  
  def display_name
    self.name
  end

index do
  column :id
  column :name
  column :bbnb
  column :primerinsfor
  column :primerinsrev
  column :batch_nb
  column :created_at
  column :updated_at
  column :strict_validation
  actions
 end
 
permit_params :id, :name, :bbnb, :primerinsfor, :primerinsrev, :batch_nb, :strict_validation, :created_at, :updated_at

#Add Button to site
action_item do
  link_to "View Site", "/"
end

end
