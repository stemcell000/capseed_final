class UnitsController < InheritedResources::Base

  private

    def unit_params
      params.require(:unit).permit(:name, :id, :clone_batch_id, :plasmid_batch_id)
    end
end

