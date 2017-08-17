ActiveAdmin.register Clone do
  
 active_admin_import validate: false,
                          template: 'import' ,
                          template_object: ActiveAdminImport::Model.new(
                              hint: "you can configure CSV options",
                              csv_options: { col_sep: ";", row_sep: nil, quote_char: nil }
                          )

  
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
