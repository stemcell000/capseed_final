ActiveAdmin.register Primer do
config.sort_order = 'id_asc'

permit_params :id, :number, :name, :sequence
 
    index do
        column :id
        column :name
        column :number
        column :sequence
    end

end
