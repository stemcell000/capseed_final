class ModifyOptions < ActiveRecord::Migration
  def change
    rename_column :options, :display_hidden_virus, :display_limited_virus
    remove_column :options, :display_hidden_clone_batch
  end
end
