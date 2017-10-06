ActiveAdmin.register Gene do
 
  index do
    column :id
    column :name
    column :clone_batch
   end

  
##Import csv   
 active_admin_import validate: false,
              csv_options: {col_sep: ";" },
              headers_rewrites: { 'plasmid' => :clone_batch_id},
              before_batch_import: ->(importer) {
                
                Gene.where(id: importer.values_at('id')).delete_all
                
                clone_batch_names = importer.values_at(:clone_batch_id)
                clone_batches   = CloneBatch.where(name: clone_batch_names).pluck(:name, :id)
                options = Hash[*clone_batches.flatten]
                importer.batch_replace(:clone_batch_id, options)
                
              },
              batch_size: 1000


permit_params :list, :of, :attributes, :on, :model, :id, :name, :clone_batch_id

#Add Button to site
action_item do
  link_to "View Site", "/"
end

end
