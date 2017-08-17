class Sma1sController < InheritedResources::Base

  private

    def sma1_params
      params.require(:sma1).permit(:name)
    end
end

