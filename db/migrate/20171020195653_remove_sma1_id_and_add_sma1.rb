class RemoveSma1IdAndAddSma1 < ActiveRecord::Migration
  def change
    remove_column :plasmid_batch_qcs, :sma1_id
    add_column :plasmid_batch_qcs, :sma1, :string
  end
end
