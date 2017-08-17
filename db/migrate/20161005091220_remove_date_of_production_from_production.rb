class RemoveDateOfProductionFromProduction < ActiveRecord::Migration
  def change
    remove_column :productions, :date_production
    remove_column :productions, :date_order
  end
end
