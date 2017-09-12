ActiveAdmin.register CloneBatch do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :list, :of, :attributes, :on, :model, :id, :name, :temp_name, :comment, :qc_validation, :strict_validation, :plasmid_validation,
:strand_as_plasmid, :date_as_plasmid, :glyc_stock_box_as_plasmid, :origin_as_plasmid, :type_as_plasmid, :comment_as_plasmid, :promoter_as_plasmid,
:gene_as_plasmid, :created_at, :updated_at, :type_id, :clone_id

#Add Button to site
action_item do
  link_to "View Site", "/"
end

end
