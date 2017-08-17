class VolUnitsController < InheritedResources::Base

  private

    def vol_unit_params
       params.require(:vol_unit).permit(:name, :id, :plasmid_batch_id)
    end
end

