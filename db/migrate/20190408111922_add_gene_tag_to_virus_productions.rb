class AddGeneTagToVirusProductions < ActiveRecord::Migration
  def change
    add_column :virus_productions, :genes_tag, :string
  end
end
