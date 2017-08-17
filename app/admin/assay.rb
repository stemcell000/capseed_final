ActiveAdmin.register Assay do

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
  column :display
  column :step
  column :last_step
  column :created_at
  column :updated_at

  actions
 end
 
permit_params :list, :of, :attributes, :on, :model, :id, :name, :display, :step, :last_step, :created_at, :updated_at

#Add Button to site
action_item do
  link_to "View Site", "/"
end

end
