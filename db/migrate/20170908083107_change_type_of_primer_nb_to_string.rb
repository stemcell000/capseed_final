class ChangeTypeOfPrimerNbToString < ActiveRecord::Migration
  def change 
    change_table :clone_batch_qcs do |t|
      t.change :primer_nb, :string
    end
  end
end
