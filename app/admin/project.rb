ActiveAdmin.register Project do
#Strong parameters
 permit_params :list, :of, :attributes, :on, :model, :id, :name
  #
 action_item do
  link_to "View Site", "/"
 end
#
 config.sort_order = 'id_asc'

  #filter
  filter :name
  filter :id
  
  #index columns
  index do
    selectable_column
    column :id
    column :name, sortable: :name do |project|
    link_to project.name, admin_project_path(project)
  end
    column :created_at
    column :updated_at
end

 #Import csv   
 active_admin_import validate: true,
             csv_options: {col_sep: ";" },
             before_batch_import: ->(importer) {
                
                #Project.where(id: importer.values_at('id')).delete_all
              },
              batch_size: 1000 
   
   
   
   
end
