class RemoveUserIdFromProduction < ActiveRecord::Migration
  def change
    remove_column :productions, :user_id
  end
end
