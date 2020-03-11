class AddDateOfProductionToVirusProduction < ActiveRecord::Migration
  def change
    add_column :virus_productions, :date_of_production, :date
  end
end
