class BoxesController < InheritedResources::Base
 
 def create
   @box = Box.new(box_params)
   @box.save
 end
 
  private

    def box_params
      params.require(:box).permit(:name, :plasmid_batch [:id, :name, :plasmid_batch_id], plasmid_batch_ids: [])
    end
    
    def load_box
      @box = Box.find(params[:box_id])
    end
end

