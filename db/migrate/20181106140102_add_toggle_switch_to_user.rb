class AddToggleSwitchToUser < ActiveRecord::Migration
  def change
    add_column :users, :toggle_switch, :boolean, :default=>false
  end
end
