class AddProductionVolumeToProduction < ActiveRecord::Migration
  def change
    add_column :productions, :production_volume, :decimal
  end
end
