class AddHiddenVpToOptions < ActiveRecord::Migration
  def change
    add_column :options, 'hidden_vp', :integer, array: true, default: []
    add_column :options, 'hidden_cb', :integer, array: true, default: []
  end
end
