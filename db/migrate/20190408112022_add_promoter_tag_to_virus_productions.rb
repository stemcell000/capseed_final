class AddPromoterTagToVirusProductions < ActiveRecord::Migration
  def change
    add_column :virus_productions, :promoters_tag, :string
  end
end
