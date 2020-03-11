class DropPrimerFAndPrimerR < ActiveRecord::Migration
  def change
    drop_table :primer_rs
    drop_table :primer_fs
  end
end
