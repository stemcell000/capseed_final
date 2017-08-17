class AddVolUnitIdToVirusProduction < ActiveRecord::Migration
  def change
    add_column :virus_productions, :vol_unit_id, :integer
  end
end
