ActiveAdmin.register Clone do
 #Add Button to site
action_item do
   link_to "View Site", "/"
end 
  
  
#Import csv   
 active_admin_import validate: false,
              csv_options: {col_sep: ";" },
              headers_rewrites: { 'cmeth' => :cmeth_id },
              before_batch_import: ->(importer) {
                
                Clone.where(id: importer.values_at('id')).delete_all
                
                cmeth_names = importer.values_at(:cmeth_id)
                cmeths   = Cmeth.where(name: cmeth_names).pluck(:name, :id)
                options = Hash[*cmeths.flatten]
                importer.batch_replace(:cmeth_id, options)    
                
              },
              batch_size: 1000
              
  show do
    h3 clone.title
    div do
      simple_format clone.name
    end
  end
              
end
