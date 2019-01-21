class DosagesController < ApplicationController


  def virus_production_params
    params.require(:dosages).permit(:id, :virus_production_id, :titer, :titer_atcc, :titer_to_atcc, :user_id, :date, :plate_name, :_destroy, :inactivation)
  end  
end
