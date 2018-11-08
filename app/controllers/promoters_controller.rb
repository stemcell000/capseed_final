class PromotersController < ApplicationController
  
  before_action :promoter_params, only:[:create]
  
 def new
   @promoter = Promoter.new
 end
 
  def create
    @promoter = Promoter.create(promoter_params)
    if @promoter.save
      flash.keep[:success] = "A new promoter has been successfully created!"
    else
      render :action => 'new'
    end
  end
  
  private
  
   def promoter_params
      params.require(:promoter).permit(:id, :name)
   end
  

end
