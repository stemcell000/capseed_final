ActiveAdmin.register CloneBatch do
 config.sort_order = 'id_asc'

  #Strong parameters
 permit_params :list, :of, :attributes, :on, :model, :id, 
                                                     :name, 
                                                     :temp_name,
                                                     :comment,
                                                     :qc_validation,
                                                     :strict_validation,
                                                     :plasmid_validation,
                                                     :strand_as_plasmid,
                                                     :date_as_plasmid,
                                                     :glyc_stock_box_as_plasmid,
                                                     :origin_as_plasmid,
                                                     :comment_as_plasmid,
                                                     :promoter_as_plasmid,
                                                     :gene_as_plasmid,
                                                     :created_at,
                                                     :updated_at,
                                                     :type_id,
                                                     :clone_id
  #filter
     filter :temp_name
     filter :comment
     filter :qc_validation
     filter :strict_validation
     filter :plasmid_validation
     filter :strand_as_plasmid
     filter :date_as_plasmid
     filter :glyc_stock_box_as_plasmid
     filter :origin_as_plasmid
     filter :comment_as_plasmid
     filter :promoter_as_plasmid
     filter :gene_as_plasmid
     filter :created_at
     filter :updated_at
     filter :type_id
     filter :clone_id
  
   #index columns
  index do
    selectable_column
    column :name, sortable: :name do |p|
    link_to p.name, admin_clone_batch_path(p)
  end
    column :temp_name
    column :comment
    column :qc_validation
    column :strict_validation
    column :plasmid_validation
    column :strand_as_plasmid
    column :date_as_plasmid
    column :glyc_stock_box_as_plasmid
    column :origin_as_plasmid
    column :comment_as_plasmid
    column :promoter_as_plasmid
    column :gene_as_plasmid
    column :created_at
    column :updated_at
    column :type_id
    column :clone_id
   
   #actions
    actions defaults: false do |p|
    link_to "Edit", edit_admin_clone_batch_path(p)
  end
   
 end
 
 #Import csv   
 active_admin_import validate: true,
             csv_options: {col_sep: ";" },
              headers_rewrites: { },
              before_batch_import: ->(importer) {
                
                CloneBatch.where(id: importer.values_at('id')).delete_all
                
                           
                
              },
              batch_size: 1000


permit_params :list, :of, :attributes, :on, :model, :id, :name, :temp_name, :comment, :qc_validation, :strict_validation, :plasmid_validation,
:strand_as_plasmid, :date_as_plasmid, :glyc_stock_box_as_plasmid, :origin_as_plasmid, :type_as_plasmid, :comment_as_plasmid, :promoter_as_plasmid,
:gene_as_plasmid, :created_at, :updated_at, :type_id, :clone_id

#Add Button to site
action_item do
  link_to "View Site", "/"
end

end
