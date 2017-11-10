class VirusProductionsController < InheritedResources::Base
 
 
  private

    def virus_production_params
      params.require(:virus_production).permit(
      :id, :date_order, :date_production, :user_id, :plate_nb, :vol, :sterility, :plate_id, :titer_atcc, :titer, :titer_to_atcc, :comment,
      :get_prot, :invoice, :bach_end, :l2, :hek_result, :created_at, :updated_at, :vol_unit_id, :production_id
      )
    end
end

