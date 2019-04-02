ActiveAdmin.register VirusBatch do
 csv do
   column :name
   column :virus_production_id
   column :box
   column(:volume)
   column(:date)
   column(:vol_unit_id)
   column(:trash)
   column(:date_of_thawing)
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
