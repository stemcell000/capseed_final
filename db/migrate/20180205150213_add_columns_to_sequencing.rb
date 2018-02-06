class AddColumnsToSequencing < ActiveRecord::Migration
  def change
    add_column :sequencings, :clone_batch_qc_id, :integer
    add_column :sequencings, :user_id, :integer
    add_column :sequencings, :date_rec, :date
    add_column :sequencings, :date_send, :date
    add_column :sequencings, :comment, :text
    add_column :pcr_colonies, :clone_batch_qc_id, :integer
    add_column :pcr_colonies, :user_id, :integer
    add_column :pcr_colonies, :primer_F, :string
    add_column :pcr_colonies, :primer_R, :string
    add_column :pcr_colonies, :comment, :text
    add_column :pcr_colonies, :date, :date
  end
end
