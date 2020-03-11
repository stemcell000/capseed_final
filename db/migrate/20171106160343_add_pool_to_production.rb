class AddPoolToProduction < ActiveRecord::Migration
  def change
    add_column :productions, :pool, :boolean
  end
end
