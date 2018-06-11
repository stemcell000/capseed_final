class VirusProductionsController < InheritedResources::Base
  
  #Smart_listing
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
 def index
   #"between search": recherche dans un range de dates
      
      #Formattage des dates
      start_time = params[:created_at_gteq].to_date rescue Date.current
      start_time = start_time.beginning_of_day # sets to 00:00:00
      end_time = params[:created_at_lteq].to_date rescue Date.current
      end_time = end_time.end_of_day # sets to 23:59:59
      
      start_prod_time = params[:date_of_production_gteq].todate rescue Date.current
      start_prod_time = start_prod_time.beginning_of_day # sets to 00:00:00
      end_prod_time = params[:date_of_production_lteq].to_date rescue Date.current
      end_prod_time = end_prod_time.end_of_day # sets to 23:59:59
      
    #Champ select pour "step" (champ de Production) et "projects" 
    
      @users_all = User.all.order(lastname: "asc").uniq
      @users_all = @users_all.map{ |obj| [(obj['firstname']+" "+obj['lastname']), obj['id']] }
      
      #          
      @q = VirusProduction.ransack(params[:q])
      @vps = @q.result(distinct: true).includes(:user)
    
      #Config de l'affichage des résultats.
      @vps = smart_listing_create(:virus_productions, @vps, partial: "virus_productions/smart_listing/list", default_sort: {id: "asc"}, page_sizes: [ 10, 20, 30, 50, 100])  
 end
 
 def edit
   @vp = VirusProduction.find(params[:id])
 end
 
 def update
   @vp = VirusProduction.find(params[:id])
   @production = @vp.production
   @vps = @production.virus_productions
   #
   @vp.update_attributes(virus_production_params)
    if @vp.valid?
      flash.keep[:success] = "Task completed!"
    else
      render :action => 'edit'
    end
  end
  
  
  def edit_from_inventory
      @vp = VirusProduction.find(params[:id])
      #@vp.dosages.build
      @users = User.all
  end
  
  def update_from_inventory
      @vp = VirusProduction.find(params[:id])
      @vp.update_attributes(virus_production_params)
  end 
  
  def destroy
     @vp = VirusProduction.find(params[:id])
     @vps = VirusProduction.all
     @vp.destroy
  end
  
  def new
    @vp = VirusProduction.new
  end
  
  def create
        @vp = VirusProduction.create(virus_production_params)

      if  @vp.valid?
          flash.keep[:success] = "Task completed!"
      else
          render :action => :new
      end
  end
  
  def spawn_dosage
    @virus_production = VirusProduction.find(params[:id])
    @users = User.all
  end
  
  def create_dosage
    @virus_production = VirusProduction.find(params[:id])
    production = @virus_production.production
    @vps = production.virus_productions
     @virus_production.update_attributes(virus_production_params)
     if @virus_production.valid?
      flash.keep[:success] = "Task completed!"
    else
      render :action => 'spawn_dosage'
    end
  end
  
 
  def virus_production_params
    params.require(:virus_production).permit(:id, :user_id, :plate_nb, :vol, :sterility, :plate_id, :titer_atcc, :titer, :titer_to_atcc, :comment, :date_of_production,
    :gel_prot, :invoice, :batch_end, :l2, :hek_result, :created_at, :updated_at, :vol_unit_id, :production_id,
    :dosages_attributes => [:id, :virus_production_id, :titer, :titer_atcc, :titer_to_atcc, :user_id, :date, :_destroy, :remove_dosage])
  end
 
end

