class ProductionsController < InheritedResources::Base
  
  before_filter :authenticate_user!
  before_action :ranked_productions, only: [:index]
  before_action :production_params, only:[:create, :update_row_order, :update, :add_cbs]
  before_action :set_production, only:[:edit, :update, :add_plasmid, :virus_production, :select_cbs, :add_cbs]
  
#Smart_listing
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper 
  
  def index
    @productions = Production.where("last_step <?", 3 ).rank(:row_order).all
    #update des dates de process en cours
      @productions.each do |p|
        if !p.locked
          p.update_columns(:today_date => Date.today)
        end
    end
  end
  
  def update_row_order
    @production = Production.find(production_params[:production_id])
    @production.row_order_position = production_params[:row_order_position]
    @production.save
    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end
  
 def ranked_productions
    #Refresh the collection of productions
    @productions = Production.rank(:row_order).where.not(step: "completed" , display: false)
 end
 
 def new
    @production = Production.new
    @production.projects.build
 end
 
 def create
    #Create new production
    @production = Production.create(production_params)
    
    if @production.save
      flash.keep[:success] = "Production was successfully created!"
      redirect_to @production
      @production.update_columns(:step => 0)
      update_last_step(@production, 0)
      @production.update_columns(:percentage => 30)
    else
      render :action => 'new'
    end
 end
 
 def edit
   @production.update_columns(:step => 0)
 end
 
 def update
   @projects_all = Project.all
   @production.update_attributes(production_params)
    if @production.valid?
      flash.keep[:success] = "Task completed!"
      redirect_to :action => :add_plasmid
            @production.update_columns(:step => 0)
            @production.update_columns(:percentage => 25)
    else
      render :action => 'edit'
    end
  end
  
  def show
    redirect_to :action => :add_plasmid
  end

  def add_plasmid
    @clone_batches = @production.clone_batches.order(:id)
      #
      @cb_helpers = @production.clone_batches.where(:type_id => 1)
      @cb_transgenes = @production.clone_batches.where(:type_id => 2)
      @cb_capsids = @production.clone_batches.where(:type_id => 3)
      @cb_libraries = @production.clone_batches.where(:type_id => 4)
      @cb_nones = @production.clone_batches.where(:type_id => 5)
      @cb_unknowns = @production.clone_batches.where(:type_id => 6)
      #
    @production.update_columns(:step => 1)
    update_last_step(@production, 1)
    @production.update_columns(:percentage => 50)
  end
 
  def select_cbs
     @production = Production.find(params[:id])
      #
      @cb_helpers = CloneBatch.all.where(:type_id => 1)
      @cb_transgenes = CloneBatch.all.where(:type_id => 2)
      @cb_capsids = CloneBatch.all.where(:type_id => 3)
      @cb_libraries = CloneBatch.all.where(:type_id => 4)
      #
      @production.update_columns(:strict_validation => 1)
  end
  
  def add_cbs
    @production.update_attributes(production_params)
    @clone_batches = @production.clone_batches.order(:type_id)
     flash.keep[:success] = "Task completed!"
        @production.update_columns(:step => 0)
        @production.update_columns(:percentage => 50)
  end
  
   def remove_from_prod
      @clone_batch = CloneBatch.find(params[:id])
      @production = Production.find(@clone_batch.production_id)
      @clone_batches = @production.clone_batches
      @clone_batches.delete(@clone_batch)
   end
   
   def pool
     #
     @production = Production.find(params[:production_id])
     #
     @production.update_attributes(production_params)
   end
   
 
  def virus_production
    @production = Production.find(params[:id])
    
    @vps = @production.virus_productions
    
    @clone_batches = @production.clone_batches.order(:id)
      #
      @cb_helpers = @production.clone_batches.where(:type_id => 1)
      @cb_transgenes = @production.clone_batches.where(:type_id => 2)
      @cb_capsids = @production.clone_batches.where(:type_id => 3)
      @cb_libraries = @production.clone_batches.where(:type_id => 4)
      @cb_nones = @production.clone_batches.where(:type_id => 5)
      @cb_unknowns = @production.clone_batches.where(:type_id => 6)
      #
    @production.update_columns(:step => 2)
    update_last_step(@production, 2)
    @production.update_columns(:percentage => 75)
    @production.update_columns( :locked => true )
    #
    flash.keep[:success] = "Production has beed launched."
  end
  
  def spawn_vp
    @production = Production.find(params[:production_id])
    #Ligne suivante indispensable pour nested_form
     @production.virus_productions.build
  end
  
  def create_vp
     @production = Production.find(params[:id])
     #production_vp_params doit contenir production_id dans les attribut de virus_production (nested). Sinon impossible d'ajouter nouveau virus_production
     @production.update_attributes(production_vp_params)
     @vps = @production.virus_productions
     
     if @production.valid?
      flash.keep[:success] = "Task completed!"
    else
      render :action => 'spawn_vp'
    end
  end
  
  def remove_vp_from_prod
      @vp = VirusProduction.find(params[:id])
      @production = Production.find(@vp.production_id)
      @vps = @production.virus_productions
      @vps.delete(@vp)
 end
 
 def close
    @production = Production.find(params[:id])
    @production.update_columns(:step => 3)
    update_last_step(@production, 3)
    @production.update_columns(:percentage => 100)
    redirect_to :action => :index
 end
  
  def display_all
    
    #"between search": recherche dans un range de dates
      
      #Formattage des dates
      start_time = params[:created_at_gteq].to_date rescue Date.current
      start_time = start_time.beginning_of_day # sets to 00:00:00
      end_time = params[:created_at_lteq].to_date rescue Date.current
      end_time = end_time.end_of_day # sets to 23:59:59
      
    #Champ select pour "step" (champ de Production) et "projects" 
      @steps = Array.new()
      @steps_all =Array.new()
      Production.all.each do |p |
        name = formatProdStepName(p.step)
        @steps << { "id" => p.step, "name" => name } 
      end
      @steps = @steps.sort_by { |hsh| hsh[:id] }.uniq.map { |obj| [obj['name'], obj['id']] }
      @projects_all = Project.all.order(name: "asc").uniq
      @projects_all = @projects_all.map{ |obj| [obj['name'], obj['id']] }
      
      #          
      @q = Production.ransack(params[:q])
      @productions = @q.result(distinct: true).includes(:projects)
    
      #Config de l'affichage des résultats.
      @productions = smart_listing_create(:productions, @productions, partial: "productions/smart_listing/list", default_sort: {created_at: "asc"}, page_sizes: [ 10, 20, 30, 50, 100])  
  end
  

  
  def scheduler
    
    if params[:nb] 
    unless params[:nb].blank?
      @producions = Production.all.order("id desc").limit(params[:nb])
    else
      @productions = Production.all.order("id desc").limit(10)
    end
    else
      @productions = Production.all.order("id desc").limit(10)
    end
    
    gon.rabl "app/views/productions/scheduler.json.rabl", as: "productions"

  end
  

  private
  def set_production
    @production = Production.find(params[:id])
  end

  def production_params
    params.require(:production).permit(:id, :production_id, :name, :display, :step, :comment, :created_at , :updated_at , :row_order_position, :locked, :percentage, :pool,
    project_ids: [],
    :projects_attributes => [:id, :name],
    :clone_batch_attributes => [:id, :name, :promoted, :comment, :qc_validation, :clone_batch_id, :clone_id, :_destroy, :production_id],
    clone_batch_ids: [],
    :clone_attributes => [:id, :name, :assay_id],
    :assay_attributes => [:id, :name],
    :virus_production_attributes => [:id, :production_id, :date_order, :date_production, :user_id, :plate_nb, :vol, :sterility, :plate_id, :titer_atcc, :titer, :titer_to_atcc, :comment,
    :get_prot, :invoice, :bach_end, :l2, :hek_result, :created_at, :updated_at, :vol_unit_id],
    virus_production_ids: []
    )
  end
    
  def production_vp_params
    params.require(:production).permit(:id,
    :virus_productions_attributes => [:id, :date_order, :date_production, :user_id, :plate_nb, :vol, :sterility, :plate_id, :titer_atcc, :titer, :titer_to_atcc, :comment,
    :gel_prot, :invoice, :batch_end, :l2, :hek_result, :created_at, :updated_at, :vol_unit_id, :production_id],virus_production_ids: [])
  end
    
   def formatProdStepName(i)
    case i
    when 0
      s = "creation"
    when 1
      s = "production design"
    when 2
      s = "production of virus"
    when 3
      s = "close production"
    end
     return s
  end
    
  def reformatdate(d)
    d = Date.strptime(d,"%m/%d/%Y").end_of_day
    d = d.strftime('%Y-%m-%d')
  end

end

