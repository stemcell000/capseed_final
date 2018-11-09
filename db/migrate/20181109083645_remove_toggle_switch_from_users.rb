class RemoveToggleSwitchFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :toggle_switch
  end
end
