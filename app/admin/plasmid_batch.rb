ActiveAdmin.register PlasmidBatch do
  
  config.sort_order = 'id_asc'

  #Strong parameters
 permit_params :list, :of, :attributes, :on, :model, :trash, :name, :number, :format_id, :concentration, :unit_id, :box_id, :row_id, :column_id, :clone_batch_id, :vol_unit, :volume
   
 
 #Import csv   
 active_admin_import validate: true,
             csv_options: {col_sep: ";" },
              before_batch_import: ->(importer) {
                
                PlasmidBatch.where(id: importer.values_at('id')).delete_all
                
                          
              },
              batch_size: 1000

  #Add Button to site
  action_item do
    link_to "View Site", "/"
  end
end
