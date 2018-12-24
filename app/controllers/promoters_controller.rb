class PromotersController < ApplicationController
  
  before_action :promoter_params, only:[:create, :update]
  before_action :find_promoter, only: [:edit, :destroy, :update]
  
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
 def new
   @promoter = Promoter.new
 end
 
 
 def edit
 end
 
  def create
    @promoter = Promoter.create(promoter_params)
    if @promoter.save
      flash.keep[:success] = "A new promoter has been successfully created!"
    else
      render :action => 'new'
    end
  end
  
  def update
     @promoter.update_attributes(promoter_params)
  end
 
 def index
    @promoters = smart_listing_create(:promoters, Promoter.all, partial: "promoters/list", default_sort: {name: "asc"},  page_sizes: [10, 20, 30, 50, 100])   
 end
 
 def destroy
   @promoter.destroy
 end
  
  private
   
   def find_promoter
      @promoter = promoter.find(params[:id])
   end
 
   def promoter_params
      params.require(:promoter).permit(:id, :name)
   end
  

end
