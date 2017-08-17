class CreateCloneBatchQcs < ActiveRecord::Migration
  def change
    create_table :clone_batch_qcs do |t|
      t.belongs_to :clone_batch, index:true
      t.integer :primer_nb
      t.string :primer_name
      t.date :date_send
      t.date :date_rec
      t.string :rec_name
      t.text :result
      t.boolean :conclusion

      t.timestamps null: false
    end
  end
end
