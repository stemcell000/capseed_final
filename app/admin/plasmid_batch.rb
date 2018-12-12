ActiveAdmin.register PlasmidBatch do
  
  config.sort_order = 'id_asc'

  #Strong parameters
 permit_params :list, :of, :attributes, :on, :model, :trash, :name, :number, :format_id, :concentration, :unit_id, :box_id, :row_id, :column_id, :clone_batch_id, :vol_unit, :volume
   
  #filter
  filter :id
  filter :name
  filter :number
  filter :temp_name
  filter :clone_batch, :label => "plasmid"
  filter :format
  filter :box
  filter :row
  filter :column
  filter :trash
  filter :concentration
  filter :unit, :label => "conc. units"
  filter :volume
  filter :vol_unit, :label => "vol. units"
  
   #index columns
  index do
    selectable_column
    column :name, sortable: :name do |pb|
    link_to pb.name, admin_plasmid_batch_path(pb)
  end
    column :id
    column :number
    column 'plasmid', :clone_batch 
    column :format
    column :concentration
    column 'conc. units', :unit
    column :volume
    column :vol_unit
    column :box
    column :qc_validation
    column :created_at
    column :updated_at
    column :box
    column :row
    column :column
    column :trash
   
   #actions
    actions defaults: false do |pb|
    link_to "Edit", edit_admin_plasmid_batch_path(pb)
  end
   
 end
 
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
