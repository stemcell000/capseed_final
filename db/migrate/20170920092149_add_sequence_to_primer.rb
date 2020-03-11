class AddSequenceToPrimer < ActiveRecord::Migration
  def change
    add_column :primers, :sequence, :text
  end
end
