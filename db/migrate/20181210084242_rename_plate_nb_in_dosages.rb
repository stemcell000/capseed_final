class RenamePlateNbInDosages < ActiveRecord::Migration
  def change
    rename_column :dosages, :plate_nb, :plate_name
  end
end
