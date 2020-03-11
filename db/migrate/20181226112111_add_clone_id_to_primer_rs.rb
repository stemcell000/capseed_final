class AddCloneIdToPrimerRs < ActiveRecord::Migration
  def change
    add_column :primer_rs, :clone_id, :integer
    add_column :primer_fs, :clone_id, :integer
  end
end
