ActiveAdmin.register Production do
#Strong parameters
 permit_params :list, :of, :attributes, :on, :model, :id, :name, :locked, :pbtag, :cbtag, :today_date
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
    column :pbtag
    column :cbtag
    actions
end


  #Import csv   
 active_admin_import validate: true,
             csv_options: {col_sep: ";" },
             before_batch_import: ->(importer) {
                Production.where(id: importer.values_at('id')).delete_all
              },
              batch_size: 1000 
   
   
   
end
