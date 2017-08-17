class ChangeColumnsTypeInVirusProduction2 < ActiveRecord::Migration
  def change
    change_column :virus_productions, :sterility, 'integer USING CAST(sterility AS integer)'
  end
end
