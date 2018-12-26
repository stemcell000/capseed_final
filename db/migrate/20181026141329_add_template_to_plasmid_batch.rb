class AddTemplateToPlasmidBatch < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :trash, :boolean, default: false
  end
end
