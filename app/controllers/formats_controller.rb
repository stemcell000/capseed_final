class FormatsController < InheritedResources::Base

  private

    def format_params
      params.require(:format).permit(:name)
    end
end

