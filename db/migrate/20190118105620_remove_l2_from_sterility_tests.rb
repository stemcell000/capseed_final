class RemoveL2FromSterilityTests < ActiveRecord::Migration
  def change
    remove_column :sterilitytests, :l2
  end
end
