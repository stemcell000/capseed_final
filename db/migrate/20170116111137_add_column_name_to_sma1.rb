class AddColumnNameToSma1 < ActiveRecord::Migration
  def change
    add_column :sma1s, :name, :string
  end
end
