class AddFormatIdToPlasmidBatch < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :format_id, :integer
  end
end
