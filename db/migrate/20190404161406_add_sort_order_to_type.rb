class AddSortOrderToType < ActiveRecord::Migration
  def change
    add_column :types, :order_set, :integer
  end
end
