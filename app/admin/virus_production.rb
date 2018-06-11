ActiveAdmin.register VirusProduction do
  #index columns
  index do
    column :id, sortable: :id do |vp|
      link_to vp.id, admin_virus_production_path(vp)
    end
    column :name
    column :vol_unit
    column :name
    column :plate_id
    column :vol
    column :sterility
    column :plate_id
    column :comment
    column :gel_prot
    column :invoice
    column :batch_end
    column :l2
    column :hek_result
    column :target
    column :animal
    column :production_id
   #actions
    actions defaults: false do |p|
    link_to "Edit", edit_admin_virus_production_path(p)
  end
end
#Import csv   
 active_admin_import validate: false,
              csv_options: {col_sep: ";" },
              headers_rewrites: { 'username' => :user_id },
              before_batch_import: ->(importer) {
           
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

permit_params :vol_unit, :name, :plate_id, :vol, :sterility, :plate_id, :titer, :titer_atcc, :titer_to_atcc, :comment, :gel_prot, :invoice, :batch_end, :l2, :hek_result, :target, :animal

end

