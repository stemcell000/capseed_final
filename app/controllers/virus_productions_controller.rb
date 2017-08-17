class VirusProductionsController < InheritedResources::Base

  def new
    @virus_production = VirusProduction.new
    @users = User.all.order(:username)
    @vol_units =  VolUnit.all.order(:name) 
  end
  
  def create
    #validate
    #create
    #add to plasmid batch collection ONCE
  end
  
  private

    def virus_production_params
      params.require(:virus_production).permit(:date_order, :date_production, :user_id, :plate_nb, :vol, :sterility, :plate_id, :plasmid_batch_id,
      :plasmid_batches_attributes => [:clone_batch_id, :id, :production_id, :format, :concentration, :comment, :unit_id , :box_id, :row_id, :column_id, :production_id, :strict_validation],
      users_ids: [],
      :user_attributes => [:id, :username, :full_name])
    end
    
    def load_production
      @production = Production.find(params[:production_id])
    end
end

