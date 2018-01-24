ActiveAdmin.register Clone do
  
  def display_name
    self.name
  end

index do
  column :id
  column :name
  column :bbnb
  column :primerinsfor
  column :primerinsrev
  column :batch_nb
  column :created_at
  column :updated_at
  column :strict_validation
  actions
 end
 
 
  #Import csv   
 active_admin_import validate: false,
              csv_options: {col_sep: ";" },
              headers_rewrites: { 'cmeth' => :cmeth_id },
              before_batch_import: ->(importer) {
                
                cmeth_names = importer.values_at(:cmeth_id)
                cmeths   = Cmeth.where(name: cmeth_names).pluck(:name, :id)
                options = Hash[*cmeths.flatten]
                importer.batch_replace(:cmeth_id, options)
                
              },
              batch_size: 1000
 
permit_params :id, :name, :primerinsfor, :primerinsrev, :comment, :cmeth_id ,:strict_validation, :created_at, :updated_at

#Add Button to site
action_item do
  link_to "View Site", "/"
end

end
