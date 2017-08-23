ActiveAdmin.register PlasmidBatch do

  #Strong parameters
 permit_params :list, :of, :attributes, :on, :model, :name, :number, :format_id, :concentration, :unit_id, :box_id, :row_id, :column_id, :clone_batch_id
   
   #index columns
  index do
    id_column
    column :name
    column :number
    column :format
    column :concentration
    column :volume
    column :box
    column :qc_validation
    column :created_at
    column :updated_at
    column :box
    column :row
    column :column
    column :clone_batch
   actions
 end
 
 #Import csv   
 active_admin_import validate: true,
             csv_options: {col_sep: ";" },
              headers_rewrites: { :'format' => :format_id, :'unit' => :unit_id, :'box' => :box_id, :'plasmid' => :clone_batch_id  },
              before_batch_import: ->(importer) {
                
                PlasmidBatch.delete_all
                
                format_names = importer.values_at(:format_id)
                # replacing format name with format id
                formats   = Format.where(name: format_names).pluck(:name, :id)
                options = Hash[*formats.flatten] # #{"midi" => 2, "mini" => 1}
                importer.batch_replace(:format_id, options) #replacing "mini" with 1, etc
                
                unit_names = importer.values_at(:unit_id)
                # replacing unit name with unit id
                units   = Unit.where(name: unit_names).pluck(:name, :id)
                options = Hash[*units.flatten] 
                importer.batch_replace(:unit_id, options) 
                
                box_names = importer.values_at(:box_id)
                # replacing unit name with box id
                boxes   = Box.where(name: box_names).pluck(:name, :id)
                options = Hash[*boxes.flatten] 
                importer.batch_replace(:box_id, options)
                
                plasmid_names = importer.values_at(:clone_batch_id)
                # replacing unit name with clone batch id
                plasmids  = CloneBatch.where(name: plasmid_names).pluck(:name, :id)
                options = Hash[*plasmids.flatten] 
                importer.batch_replace(:clone_batch_id, options) 
                
                
              },
              batch_size: 1000


  #Add Button to site
  action_item do
    link_to "View Site", "/"
  end


end
