class AddCloneBatchPromoter < ActiveRecord::Migration
  def change
          create_table :clone_batches_promoters do |t|
           t.belongs_to :clone_batch, index: true
           t.belongs_to :promoter, index: true
        end
  end
end
