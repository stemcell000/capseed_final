class PrimersController < ApplicationController
  before_action :primer_params, only:[:create, :update]
  before_action :find_primer, only: [:edit, :destroy, :update, :create]
  
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
 def new
   @primer = Primer.new
 end
 
 def edit
 end
 
  def create
    @primer = primer.create(primer_params)
    if @primer.save
      flash.keep[:success] = "A new primer has been successfully created!"
    else
      render :action => 'new'
    end
  end
  
  def update
     @primer.update_attributes(primer_params)
  end
 
 def index
    @primers = smart_listing_create(:primers, Primer.all, partial: "primers/list", default_sort: {name: "asc"},  page_sizes: [10, 20, 30, 50, 100])   
 end
 
 def destroy
   @primer.destroy
 end
 
def availability_switch
  @primer.toggle! :actual_member
  @primers = smart_listing_create(:primers, Primer.all, partial: "primers/list", default_sort: {:name => "asc"},  page_sizes: [10, 20, 30, 50, 100])
end
  
  private
   def primer_params
      params.require(:primer).permit(:name, :sequence, :_destroy, :available)
   end
   
   def find_primer
      @primer = primer.find(params[:id])
   end
end

  
