class AddPcrColonyIdToPrimer < ActiveRecord::Migration
  def change
    add_column :primers, :pcr_colony_id, :integer
  end
end
