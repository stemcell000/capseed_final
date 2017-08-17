class CreateClonesCloneBatches < ActiveRecord::Migration
  def change
    create_table :clone_batches_clones, force: :cascade do |t|
      t.integer "clone_id", null: false
      t.integer "clone_batch_id", null: false
    end
  end
end
