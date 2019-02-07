class AddPlasmidTagToVirusProductions < ActiveRecord::Migration
  def change
    add_column :virus_productions, :plasmid_tag, :string
    add_column :virus_productions, :plasmid_batch_tag, :string
  end
end
