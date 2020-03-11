class RemoveCategoryFromEnzyme < ActiveRecord::Migration
  def change
    remove_column :enzymes, :category
  end
end
