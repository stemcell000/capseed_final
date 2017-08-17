class InsertsController < InheritedResources::Base

def create
  if !params[:clone_batch_id].nil?
  
    @clone_batch = CloneBatch.find[:clone_batch_id]

  end
end
 
 
  private

    def insert_params
      params.require(:insert).permit(:id, :name, :number, :clone_batch_id,
      clone_ids[],
      :clones_attributes => [:id, :name, :primerinsfor, :primerinsrev, :bbnb, :comment, :comment_batch, :batch_nb, :strict_validation])
    end
end

