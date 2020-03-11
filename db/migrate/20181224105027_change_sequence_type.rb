class ChangeSequenceType < ActiveRecord::Migration
  def change
    change_column :primers, :sequence, :text
  end
end
