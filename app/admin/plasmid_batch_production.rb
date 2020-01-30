ActiveAdmin.register PlasmidBatchProduction do
#Import csv   
 active_admin_import validate: false,
              csv_options: {col_sep: ";" },
              before_batch_import: ->(importer) {
              PlasmidBatchProduction.where(id: importer.values_at('id')).delete_all
              },
              batch_size: 1000
              
#Add Button to site
action_item do
  link_to "View Site", "/"
end

#

index do
    selectable_column
    column :id
    column :created_at
    column :updated_at
    column :production_id
    column :plasmid_batch_id
    column :volume
    column :starting_volume
    actions
end
#

permit_params :list, :of, :attributes, :on, :model, :volume, :starting_volume

end
