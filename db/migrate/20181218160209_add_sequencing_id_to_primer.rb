class AddSequencingIdToPrimer < ActiveRecord::Migration
  def change
    add_column :primers, :sequencing_id, :integer
  end
end
