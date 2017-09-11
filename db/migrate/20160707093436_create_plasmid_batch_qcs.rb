class CreatePlasmidBatchQcs < ActiveRecord::Migration
  def change
    create_table :plasmid_batch_qcs do |t|
      t.belongs_to :plasmid_batch, index:true
      t.string :dig_smal
      t.string :dig_other
      t.string :itr
      t.text :comments
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
