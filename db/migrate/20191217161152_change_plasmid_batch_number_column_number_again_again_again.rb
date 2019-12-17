class ChangePlasmidBatchNumberColumnNumberAgainAgainAgain < ActiveRecord::Migration
  def change
    change_column :plasmid_batches, :number, 'integer USING CAST(number AS integer)'
  end
end
