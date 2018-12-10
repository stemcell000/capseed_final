class RemoveL2FromVirusProductions < ActiveRecord::Migration
  def change
    add_column :sterilitytests, :l2, :boolean
    remove_column :virus_productions, :l2
  end
end
