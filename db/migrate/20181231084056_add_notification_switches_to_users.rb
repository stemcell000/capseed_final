class AddNotificationSwitchesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cloning_notify, :boolean, default: true
    add_column :users, :production_notify, :boolean, default: true
  end
end
