class CreateCloneBatchesProductions < ActiveRecord::Migration
  def up
    create_table :clone_batches_productions do |t|
           t.belongs_to :clone_batch, index: true
           t.belongs_to :production, index: true
           
    end
  end
  def down
    drop_table :clone_batches_productions
  end
end
