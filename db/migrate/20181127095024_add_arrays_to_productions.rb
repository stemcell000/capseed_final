class AddArraysToProductions < ActiveRecord::Migration
  def change
    add_column :productions, :cbarr, :string, array: true, default: []
    add_column :productions, :pbarr, :string, array: true, default: []
  end
end
