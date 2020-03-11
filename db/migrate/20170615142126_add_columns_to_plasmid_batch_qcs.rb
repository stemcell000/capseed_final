class AddColumnsToPlasmidBatchQcs < ActiveRecord::Migration
  def change
    add_column :plasmid_batch_qcs, :primer1, :string
    add_column :plasmid_batch_qcs, :primer2, :string
    add_column :plasmid_batch_qcs, :date_send, :date
  end
end
