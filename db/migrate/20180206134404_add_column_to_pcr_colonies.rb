class AddColumnToPcrColonies < ActiveRecord::Migration
  def change
    add_column :pcr_colonies, :primer_r, :string
    add_column :pcr_colonies, :primer_f, :string
  end
end
