ActiveAdmin.register PlasmidBatch do
  
  config.sort_order = 'id_asc'

  #Strong parameters
 permit_params :list, :of, :attributes, :on, :model, :name, :number, :format_id, :concentration, :unit_id, :box_id, :row_id, :column_id, :clone_batch_id, :vol_unit, :volume
   
  #filter
  filter :name
  filter :number
  filter :temp_name
  filter :clone_batch, :label => "plasmid"
  filter :format
  filter :box
  filter :row
  filter :column
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
   
   #actions
    actions defaults: false do |pb|
    link_to "Edit", edit_admin_plasmid_batch_path(pb)
  end
   
 end
 
 #Import csv   
 active_admin_import validate: true,
             csv_options: {col_sep: ";" },
              headers_rewrites: { :'format' => :format_id, :'unit' => :unit_id, :'vol_unit' => :vol_unit_id, :'box' => :box_id, :'plasmid' => :clone_batch_id, :'row' => :row_id, :'column' => :column_id  },
              before_batch_import: ->(importer) {
                
                PlasmidBatch.where(id: importer.values_at('id')).delete_all
                
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
                
                vol_unit_names = importer.values_at(:vol_unit_id)
                vol_units   = VolUnit.where(name: vol_unit_names).pluck(:name, :id)
                options = Hash[*vol_units.flatten] 
                importer.batch_replace(:vol_unit_id, options) 
                
                box_names = importer.values_at(:box_id)
                boxes   = Box.where(name: box_names).pluck(:name, :id)
                options = Hash[*boxes.flatten] 
                importer.batch_replace(:box_id, options)
                
                plasmid_names = importer.values_at(:clone_batch_id)
                plasmids  = CloneBatch.where(name: plasmid_names).pluck(:name, :id)
                options = Hash[*plasmids.flatten] 
                importer.batch_replace(:clone_batch_id, options)
                
                row_names = importer.values_at(:row_id)
                rows  = Row.where(name: row_names).pluck(:name, :id)
                options = Hash[*rows.flatten] 
                importer.batch_replace(:row_id, options) 

                column_names = importer.values_at(:column_id)
                columns  = Column.where(name: column_names).pluck(:name, :id)
                options = Hash[*columns.flatten] 
                importer.batch_replace(:column_id, options)                 
                
              },
              batch_size: 1000

  #Add Button to site
  action_item do
    link_to "View Site", "/"
  end


end
