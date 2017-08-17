ActiveAdmin.register PlasmidBatch do

  #Strong parameters
 permit_params :list, :of, :attributes, :on, :model, :name, :number, :format, :concentration
   
   #index columns
  index do
    id_column
    column :name
    column :number
    column :format
    column :concentration
    column :volume
    column :unit_id
    column :qc_validation
    column :created_at
    column :updated_at
    column :box_id
    column :row_id
    column :column_id
   actions
 end
    

  #Add Button to site
  action_item do
    link_to "View Site", "/"
  end


end
