class AddNbToVirusProduction < ActiveRecord::Migration
  def change
    add_column :virus_productions, :nb, :integer
  end
end
