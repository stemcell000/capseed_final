class AddPrimerToSequencing < ActiveRecord::Migration
  def change
    add_column :sequencings, :primer, :string
  end
end
