class AddCommentToVirusBatches < ActiveRecord::Migration
  def change
    add_column :virus_batches, :comment, :text
  end
end
