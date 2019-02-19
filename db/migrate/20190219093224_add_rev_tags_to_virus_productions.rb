class AddRevTagsToVirusProductions < ActiveRecord::Migration
  def change
    add_column :virus_productions, :rev_plasmid_tag, :string
    add_column :virus_productions, :rev_plasmid_batch_tag, :string
  end
end
