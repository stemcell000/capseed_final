class VirusProductionsController < InheritedResources::Base
 
   before_action :set_virus_production, only:[:edit, :destroy, :edit_from_inventory, :hide_from_inventory, :add_vb_from_inventory, :spawn_dosage, :update, :update_from_inventory, :create_dosage]
   before_action :set_option, only:[:index, :hide_from_inventory, :update_from_inventory]
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

      @plasmid_batches_all = PlasmidBatch.all.order(:id)
      @plasmid_batches_all = @plasmid_batches_all.map{|obj| [obj['name']] }
      
    #Champs genes
      @genes_all = Gene.all.order(name: "asc").uniq
      @genes_all = @genes_all.map{ |obj| [obj['name'], obj['id']] }
    #Champs promoters
      @promoters_all = Promoter.all.order(name: "asc").uniq
      @promoters_all = @promoters_all.map{ |obj| [obj['name'], obj['id']] }
      #Champs projects
      @projects_all = Project.all.order(name: "asc").uniq
      @projects_all = @projects_all.map{ |obj| [obj['name'], obj['id']] }  
      #Champ Plasmid
      @clone_batches_all = CloneBatch.all.order(name: "asc").uniq
      @clone_batches_all = @clone_batches_all.map{ |obj| [obj['name'], obj['id']] }  
      @option = current_user.options.first
      #virus cachés
      unless @option.display_all_virus
        hidden_virus_ids = @option.virus_productions.pluck(:id)
      else
        hidden_virus_ids = []
      end
        
      @q = VirusProduction.ransack(params[:q])
      
      @vps = @q.result.includes([:production, :plasmid_batches, :clone_batches, :sterilitytests, :genes, :user ]).where.not(:id => hidden_virus_ids)
      
      @vps  = @vps.limit(100) if current_user.options.first.display_limited_virus
        
      
      #Config de l'affichage des résultats.
      @vps = smart_listing_create(:virus_productions, @vps, partial: "virus_productions/smart_listing/list", default_sort: {nb: "desc"}, page_sizes: [ 20, 30, 50, 100])  

 end
 
def display_all_virus_switch
  @option = current_user.options.first
  @option.toggle!(:display_all_virus)
  redirect_to :index
end 
 
 def edit
 end
 
 def update
   @production = @virus_production.production
   @vps = @production.virus_productions
   #
   @virus_production.update_attributes(virus_production_params)
    if @virus_production.valid?
      flash.keep[:success] = "Task completed!"
      @virus_production.generate_recap
    else
      render :action => 'edit'
    end
  end
  
  
  def edit_from_inventory
      @users = User.all
  end
  
  def update_from_inventory
      @virus_production.update_attributes(virus_production_params)
      @virus_production.generate_recap
  end 
  
  def destroy
     @vps = VirusProduction.all
     @virus_production.destroy
  end
  
  def new
    @virus_production = VirusProduction.new
  end
  
  def create
        @virus_production = VirusProduction.create(virus_production_params)
      if  @virus_production.valid?
          flash.keep[:success] = "Task completed!"
          @virus_production.generate_recap
      else
          render :action => :new
      end
  end
  
  def spawn_dosage
    @virus_production = VirusProduction.find(params[:id])
    @users = User.all
  end
  
  def create_dosage
    production = @virus_production.production
    @vps = production.virus_productions
     @virus_production.update_attributes(virus_production_params)
     if @virus_production.valid?
      flash.keep[:success] = "Task completed!"
      @virus_production.generate_recap
     else
      render :action => 'spawn_dosage'
    end
  end
  
  def add_vb_from_inventory
    @users = User.all
    @virus_production.virus_batches.build
    @virus_batches = @virus_production.virus_batches
          n = VirusProduction.last.nb
          @nb = (n +1).to_s
  end
  
  def hide_from_inventory
    unless @option.virus_productions.where(:id => @virus_production.id).exists?
      @option.virus_productions << @virus_production
    else
      @option.virus_productions.destroy(@virus_production)
    end
  end
  
  private
 
  def virus_production_params
    params.require(:virus_production).permit(:id, :number, :nb, :plate_name, :vol, :sterility, :titer_atcc, :titer, :titer_to_atcc, :comment, :date_of_production, :user_id,
    :gel_prot, :invoice, :hek_result, :created_at, :updated_at, :vol_unit_id, :production_id, :_destroy, :plasmid_tag, :plasmid_batch_tag, :rev_plasmid_tag, :rev_plasmid_batch_tag,
    :dosages_attributes => [:id, :virus_production_id, :titer, :titer_atcc, :titer_to_atcc, :date, :plate_name, :_destroy, :remove_dosage,
    :inactivation, :inactivation_atcc, :inactivation_standard, :accepted, :user_id],
    :sterilitytests_attributes => [:id, :virus_production_id, :sterility, :date, :_destroy, :remove_sterilitytest],
    :virus_batches_attributes => [:id, :name, :box_id, :volume, :vol_unit_id, :row_id, :column_id, :date_of_thawing ],
    :users_attributes =>[:id, :firstname, :lastname], user_ids: [])
  end
  
 def set_virus_production
   @virus_production = VirusProduction.find(params[:id])
 end
 
 def set_option
   @option = current_user.options.first
 end
 
end

