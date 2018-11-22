class AddProductionIdToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :production_id, :integer
  end
end
