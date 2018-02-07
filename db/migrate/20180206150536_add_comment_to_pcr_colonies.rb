class AddCommentToPcrColonies < ActiveRecord::Migration
  def change
    add_column :pcr_colonies, :comment, :text
  end
end
