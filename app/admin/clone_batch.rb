ActiveAdmin.register CloneBatch do
 config.sort_order = 'id_asc'

 #Import csv   
 active_admin_import validate: false,
              csv_options: {col_sep: ";" },
              headers_rewrites: { 'clone' => :clone_id,  'type' => :type_id, 'strand' => :strand_id, 'comment' => :comment_as_plasmid, 'target' => :target_id },
              before_batch_import: ->(importer) {
                CloneBatch.where(id: importer.values_at('id')).delete_all
     
                
                type_names = importer.values_at(:type_id)
                types   = Type.where(name: type_names).pluck(:name, :id)
                options = Hash[*types.flatten]
                importer.batch_replace(:type_id, options)
                
                strand_names = importer.values_at(:strand_id)
                strands   = Strand.where(name: strand_names).pluck(:name, :id)
                options = Hash[*strands.flatten]
                importer.batch_replace(:strand_id, options)
                
                
                target_names = importer.values_at(:target_id)
                targets   = Target.where(name: target_names).pluck(:name, :id)
                options = Hash[*targets.flatten]
                importer.batch_replace(:target_id, options)
                
              },
              batch_size: 1000


permit_params :list, :of, :attributes, :on, :model, :id, :name, :strand_id, :temp_name, :comment, :qc_validation, :strict_validation, :plasmid_validation,
:date_as_plasmid, :glyc_stock_box_as_plasmid, :origin, :origin_id, :type_id, :type, :strand, :target, :target_id, :comment_as_plasmid, :promoters,
:genes, :created_at, :updated_at, :clone_id, :number, :dismissed, :nb

#Add Button to site
action_item do
  link_to "View Site", "/"
end

#FOR DATA ANALYSIS 
  #csv do
  #  column :id
  #  column :nb
  #  column :name
  #  column :type_id 
  #end
  
 index do
    column :id, sortable: :id do |cb|
      link_to cb.id, admin_virus_production_path(cp)
    end
    column :nb
    column :number
    column :name
    column :temp_name
    column :comment
    column :gel_prot
   #actions
    actions defaults: false do |p|
    link_to "Edit", edit_admin_clone_batch_path(p)
  end
end 

end
