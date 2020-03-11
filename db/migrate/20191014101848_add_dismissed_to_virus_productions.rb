class AddDismissedToVirusProductions < ActiveRecord::Migration
  def change
    add_column :virus_productions, :dismissed, :integer, default: 0
  end
end
