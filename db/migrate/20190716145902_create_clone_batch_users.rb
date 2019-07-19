class CreateCloneBatchUsers < ActiveRecord::Migration
  def change
    create_table :clone_batches_users do |t|
      t.belongs_to :clone_batch, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
