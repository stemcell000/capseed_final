ActiveAdmin.register VirusBatch do
 index do
   selectable_column
    column :id
    column :name
    column "Virus production", (:virus_production_id) do |vb| 
            vb.virus_production_id? ? vb.virus_production.nb : ""
    end
    column :volume
    column :vol_unit_name
    column :trash
    column :barcode
    column :date_of_thawing
    column :barcode
    column :box
    column :row
    column :column
   #actions
    actions 
end 
  
  
  
 csv do
   column :id
   column :name
   column :virus_production_id
   column :virus_production_nb
   column :box_id
   column :volume
   column :date 
   column :vol_unit_id
   column :trash
   column :date_of_thawing
 end
#Import csv   
 active_admin_import validate: false,
              csv_options: {col_sep: ";" },
              headers_rewrites: { 'box' => :box_id},
              before_batch_import: ->(importer) {
   
                VirusBatch.where(id: importer.values_at('id')).delete_all
                
                box_names = importer.values_at(:box_id)
                boxes   = Box.where(name: box_names).pluck(:name, :id)
                options = Hash[*boxes.flatten]
                importer.batch_replace(:box_id, options)
                
              },
              batch_size: 1000
              
#Add Button to site
action_item do
  link_to "View Site", "/"
end


end
