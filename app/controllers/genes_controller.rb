class GenesController < ApplicationController
  before_action :gene_params, only:[:create, :update]
  before_action :find_gene, only: [:edit, :destroy, :update]
  
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
 def new
   @gene = Gene.new
 end
 
 
 def edit
 end
 
  def create
    @gene = Gene.create(gene_params)
    if @gene.save
      flash.keep[:success] = "A new gene has been successfully created!"
    else
      render :action => 'new'
    end
  end
  
  def update
     @gene.update_attributes(gene_params)
  end
 
 def index
    @genes = smart_listing_create(:genes, Gene.all, partial: "genes/list", default_sort: {name: "asc"},  page_sizes: [10, 20, 30, 50, 100])   
 end
 
 def destroy
   @gene.destroy
 end
  
  private
   
   def find_gene
      @gene = Gene.find(params[:id])
   end
 
   def gene_params
      params.require(:gene).permit(:id, :name)
   end
  
  
end
