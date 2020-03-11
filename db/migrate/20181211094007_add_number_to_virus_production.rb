class AddNumberToVirusProduction < ActiveRecord::Migration
  def change
    add_column :virus_productions, :number, :string
  end
end
