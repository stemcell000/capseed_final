class AddColumnToPcrColonies < ActiveRecord::Migration
  def change
    add_column :pcr_colonies, :primer_r, :string
    add_column :pcr_colonies, :primer_f, :string
    add_column :pcr_colonies, :date, :date
    add_column :pcr_colonies, :user_id, :integer
  end
end
