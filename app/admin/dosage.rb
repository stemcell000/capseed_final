ActiveAdmin.register Dosage do
#index columns
  index do
    column :id
    column :titer
    column :titer_atcc
    column :titer_to_atcc
    column :date
    column :virus_production_id
    column :comment
    column :inactivation
    
#actions
    actions defaults: false do |p|
    link_to "Edit", edit_admin_dosage_path(p)
  end
end

#Import csv   
 active_admin_import validate: false,
              csv_options: {col_sep: ";" },
              headers_rewrites: { 'username' => :user_id },
              before_batch_import: ->(importer) {
                
                Dosage.where(id: importer.values_at('id')).delete_all
                
                user_names = importer.values_at(:user_id)
                users   = User.where(username: user_names).pluck(:username, :id)
                options = Hash[*users.flatten]
                importer.batch_replace(:user_id, options)     
                
              },
              batch_size: 1000
              
#Add Button to site
action_item do
  link_to "View Site", "/"
end

permit_params  :id, :titer, :titer_atcc, :titer_to_atcc, :virus_production_id, :user_id, :accepted


#FOR DATA ANALYSIS
<<<<<<< HEAD
  csv do
    column :id
    column :titer
    column :titer_atcc
    column :titer_to_atcc
    column :accepted
    column :virus_production_id
  end
=======
csv do
  column :id
  column :titer
  column :titer_atcc
  column :titer_to_atcc
  column :accepted
  column :virus_production_id
end
>>>>>>> sidebar
end