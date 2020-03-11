class OriginsController < InheritedResources::Base
before_action :origin_params, only:[:create]
  
 def new
   @origin = Origin.new
 end
 
  def create
    @origin = Origin.create(origin_params)
    if @origin.save
      flash.keep[:success] = "A new origin has been successfully created!"
    else
      render :action => 'new'
    end
  end
  
   def edit
   @gene = Origin.find(params[:id])
 end
 
  def update
    @origin = Origin.update_attributes(origin_params)
    if @origin.save
      flash.keep[:success] = "A new origin has been successfully updated!"
    else
      render :action => 'edit'
    end
  end
  
    def origin_params
      params.require(:origin).permit(:name, :id)
    end
end

