class PlasmidBatchProductionsController < ApplicationController
  
  def update
    
    
  end
 
 private
    def set_params
      params.require(:plasmid_batch).permit(:volume, :starting_volume, :production_id, :plasmid_batch_id)
    end 
  
end
