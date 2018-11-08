class GenesController < ApplicationController
  before_action :gene_params, only:[:create]
  
 def new
   @gene = Gene.new
 end
 
  def create
    @gene = Gene.create(gene_params)
    if @gene.save
      flash.keep[:success] = "A new gene has been successfully created!"
    else
      render :action => 'new'
    end
  end
  
  private
  
   def gene_params
      params.require(:gene).permit(:id, :name)
   end
  
end
