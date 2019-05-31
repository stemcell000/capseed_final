ActiveAdmin.register PlasmidBatch do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
 
 #Strong parameters
 permit_params :list, :of, :attributes, :on, :model, :trash, :name, :volume, :concentration,
 :clone_batch_id, :unit_id, :format, :comment, :qc_validation, :strict_validation, :volume,
 :vol_unit_id, :row_id, :column_id, :format_id, :name, :number, :user_id, :box_id, :date, :trash,
 :barcode  
 
 #Import csv   
 active_admin_import validate: true,
             csv_options: {col_sep: ";" },
              before_batch_import: ->(importer) {
                
                PlasmidBatch.where(id: importer.values_at('id')).delete_all
                
                          
              },
              batch_size: 1000

  #Add Button to site
  action_item do
    link_to "View Site", "/"
  end
  
  form do |f|
    f.semantic_errors :state
    f.inputs do 
      f.input :name 
      f.input :clone_batch, as: :select, collection: CloneBatch.all.order(:nb).map{|cb| cb.number}, input_html: { class: "select2-select" }
      f.input :format 
      f.input :concentration 
      f.input :unit 
      f.input :volume 
      f.input :vol_unit 
      f.input :box 
      f.input :row 
      f.input :column 
      f.input :user, as: :select, collection: User.all.map{|u| u.firstname+' '+u.lastname} 
      f.input :date 
      f.input :trash 
      f.input :barcode 
    end
     f.actions 
  end

end
