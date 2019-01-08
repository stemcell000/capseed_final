class VirusProductionsController < InheritedResources::Base
 
   before_action :virus_production_params, only:[:create, :update, :update_from_inventory]
  
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
      @vps = @q.result(distinct: true).includes([:user, :production, :plasmid_batches, :clone_batches, :sterilitytests, ])
    
      #Config de l'affichage des résultats.
      @vps = smart_listing_create(:virus_productions, @vps, partial: "virus_productions/smart_listing/list", default_sort: {id: "desc"}, page_sizes: [ 20, 30, 50, 100])  
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
    @users = User.all
          n = VirusProduction.last.number.to_i
          @nb = (n +1).to_s
  end
  
  def create
        @vp = VirusProduction.create(virus_production_params)
          n = VirusProduction.last.number.to_i
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
  
  def add_vb_from_inventory
    @virus_production = VirusProduction.find(params[:id])
    @users = User.all
    @virus_production.virus_batches.build
    @virus_batches = @virus_production.virus_batches
          n = VirusProduction.last.number.to_i
          @nb = (n +1).to_s
  end
  
  private
 
  def virus_production_params
    params.require(:virus_production).permit(:id, :number, :user_id, :plate_name, :vol, :sterility, :titer_atcc, :titer, :titer_to_atcc, :comment, :date_of_production,
    :gel_prot, :invoice, :batch_end, :l2, :hek_result, :created_at, :updated_at, :vol_unit_id, :production_id, :_destroy,
    :dosages_attributes => [:id, :virus_production_id, :titer, :titer_atcc, :titer_to_atcc, :user_id, :date, :plate_name, :_destroy, :remove_dosage],
    :sterilitytests_attributes => [:id, :virus_production_id, :sterility, :date, :_destroy, :remove_sterilitytest],
    :virus_batches_attributes => [:id, :name, :box_id, :volume, :vol_unit_id, :row_id, :column_id])
  end
  

 
end

