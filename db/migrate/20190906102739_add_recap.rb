class AddRecap < ActiveRecord::Migration
  def change
    add_column :clone_batches, :recap, :text
    add_column :virus_productions, :recap, :text
  end
end
