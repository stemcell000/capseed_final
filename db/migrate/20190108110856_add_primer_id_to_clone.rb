class AddPrimerIdToClone < ActiveRecord::Migration
  def change
    add_column :clones, :primer_f_id, :integer
    add_column :clones, :primer_r_id, :integer
  end
end
