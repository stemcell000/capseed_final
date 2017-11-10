class AddProductionIdToVirusProduction < ActiveRecord::Migration
  def change
    add_column :virus_productions, :production_id, :integer
  end
end
