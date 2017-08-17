class BoxesController < InheritedResources::Base
  private

    def box_params
      params.require(:box).permit(:name, :plasmid_batch[:plasmid_batch_id])
    end
    
    def load_box
      @box = Box.find(params[:box_id])
    end
end

