class AddCmethidToClone < ActiveRecord::Migration
  def change
    add_column :clones, :cmeth_id, :integer
  end
end
