class AddAvailableToPrimers < ActiveRecord::Migration
  def change
    add_column :primers, :available, :boolean, :default => true
  end
end
