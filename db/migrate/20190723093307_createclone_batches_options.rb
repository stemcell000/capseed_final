class CreatecloneBatchesOptions < ActiveRecord::Migration
  def change
    create_table :clone_batches_options do |t|
      t.belongs_to :clone_batch, index: true
      t.belongs_to :option, index: true
      t.timestamps
      t.timestamps null: false
    end
  end
end
