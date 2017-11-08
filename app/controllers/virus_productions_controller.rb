class VirusProductionsController < InheritedResources::Base

  private

    def virus_production_params
      params.require(:virus_production).permit()
    end
end

