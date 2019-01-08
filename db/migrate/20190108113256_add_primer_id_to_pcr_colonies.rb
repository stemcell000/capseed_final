class AddPrimerIdToPcrColonies < ActiveRecord::Migration
  def change
    add_column :pcr_colonies, :primer_f_id, :integer
    add_column :pcr_colonies, :primer_r_id, :integer
    remove_column :primers, :clone_id
    remove_column :primers, :pcr_colony_id
  end
end
