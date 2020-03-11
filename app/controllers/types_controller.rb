class TypesController < InheritedResources::Base

  private

    def type_params
      params.require(:type).permit(:id, :name, :order_set)
    end
end

