class AddDisableSwitchToProduction < ActiveRecord::Migration
  def change
    add_column :productions, :disable_switch, :boolean, :default => false
  end
end
