ActiveAdmin.register VirusProduction do
  #index columns
  index do
    column :id, sortable: :id do |vp|
      link_to vp.id, admin_virus_production_path(vp)
    end
    column :nb
    column :number
    column :vol_unit
    column :vol
    column :sterility
    column :comment
    column :gel_prot
    column :invoice
    column :l2
    column :hek_result
    column :target
    column :animal
    column :production_id
    column :plasmid_tag
    column :plasmid_batch_tag
    column :rev_plasmid_tag
    column :rev_plasmid_batch_tag
   #actions
    actions defaults: false do |p|
    link_to "Edit", edit_admin_virus_production_path(p)
  end
end
#Import csv   
 active_admin_import validate: false,
              csv_options: {col_sep: ";" },
              before_batch_import: ->(importer) {
           VirusProduction.where(id: importer.values_at('id')).delete_all
              },
              batch_size: 1000
              
#Add Button to site
action_item do
  link_to "View Site", "/"
end

permit_params :vol_unit, :number, :nb, :plate_id, :vol, :sterility, :plate_id, :titer, :titer_atcc, :titer_to_atcc, :comment,
:gel_prot, :invoice, :hek_result, :target, :animal, :user_id

#FOR DATA ANALYSIS 
  csv do
    column :id
    column :nb
    column :number
    column :vol_unit
    column :vol
    column :sterility
    column :comment
    column :gel_prot
    column :invoice
    column :l2
    column :hek_result
    column :target
    column :animal
    column :production_id
    column :plasmid_tag
    column :plasmid_batch_tag
    column :rev_plasmid_tag
    column :rev_plasmid_batch_tag
  end
end

