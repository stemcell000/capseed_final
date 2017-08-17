class AddNumberToInserts < ActiveRecord::Migration
  def change
    add_column :inserts, :number, :integer
  end
end
