class AddPositionProduction < ActiveRecord::Migration
  def change
      add_column :productions, :position, :integer
  end
end
