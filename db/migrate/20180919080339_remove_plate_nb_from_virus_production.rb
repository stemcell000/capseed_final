class RemovePlateNbFromVirusProduction < ActiveRecord::Migration
  def change
    add_column :dosages, :plate_nb, :string
  end
end
