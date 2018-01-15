class EnzymesController < ApplicationController
  
  before_action :enzyme_params, only:[:create]
  
 def new
   @enzyme = Enzyme.new
 end
 
  def create
    #Create new assay
    @enzyme = Enzyme.create(enzyme_params)
    if @enzyme.save
      flash.keep[:success] = "A new Enzyme has been successfully created!"
    else
      render :action => 'new'
    end
  end
  
  private
  
   def enzyme_params
      params.require(:enzyme).permit(:id, :name)
   end
end
