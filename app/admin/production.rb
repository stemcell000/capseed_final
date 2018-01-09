ActiveAdmin.register Production do
#Strong parameters
 permit_params :list, :of, :attributes, :on, :model, :id, :name, :locked, :today_date
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
    column :created_at
    column :updated_at
    actions
end


  #Import csv   
 active_admin_import validate: true,
             csv_options: {col_sep: ";" },
             before_batch_import: ->(importer) {
               
               

              },
              batch_size: 1000 
   
   
   
end