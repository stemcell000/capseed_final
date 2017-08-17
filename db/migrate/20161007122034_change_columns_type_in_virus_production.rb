class ChangeColumnsTypeInVirusProduction < ActiveRecord::Migration
  def change
    change_column :virus_productions, :sterility, :string
    change_column :virus_productions, :plate_id, :string
  end
end
