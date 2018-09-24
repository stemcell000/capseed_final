class SterilitytestsController < InheritedResources::Base

  private

    def sterilitytest_params
      params.require(:sterilitytest).permit()
    end
end

