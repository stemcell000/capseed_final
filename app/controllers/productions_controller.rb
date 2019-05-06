class ProductionsController < InheritedResources::Base
  
  before_filter :authenticate_user!
  before_action :ranked_productions, only: [:index]
  before_action :production_params, only:[:create, :update_row_order, :update, :add_pbs, :update_pb_volumes]
  before_action :production_position_params, only:[:move_higher, :move_lower, :move_highest, :move_lowest]
  before_action :set_production, only:[:edit, :edit_pb_volumes, :update, :add_plasmid, :virus_production, :select_pbs, :add_pbs, :destroy, :reset_volume, :close, :create_vp, :update_pb_volume, :set_pb_volume,
    :add_pbs, :move_higher, :move_lower, :move_highest, :move_lowest]
  
#Smart_listing
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper 
  
  def index
    @productions = Production.where("last_step <?", 3 ).rank(:row_order).all
      @productions.each do |p|
        if !p.locked
          p.update_columns(:today_date => Date.today)
        end
     #
      busy_batches =[]
      @productions.each do |prod|
         busy_batches = prod.plasmid_batches.pluck(:id).uniq unless prod.plasmid_batches.nil? 
         busy_prods = Production.where(:last_step => 1).from_plasmid_batches(busy_batches)
         busy_prods_a = busy_prods.pluck(:id).uniq
         
         # si la production n'est pas la première de celles qui utilisent au moins un batch de plasmide en commun 
         
           if (busy_prods_a-busy_batches).count > 0
             unless prod == busy_prods.first
                prod.update_columns(:disable_switch => true)
             else
                prod.update_columns(:disable_switch => false)
             end
           end
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
    @projects_all = Project.all
    
    @production = Production.create(production_params)
    
    if @production.valid?
            flash.keep[:success] = "Task completed!"
            @production.update_columns(:step => 0)
            update_last_step(@production, 0)
            @production.update_columns(:percentage => 10)
            
            @production.update_columns(:cbtag => @production.clone_batches.order(:nb).pluck(:nb).sort.join(" "))
            redirect_to @production
            
            #Recherche de doublons (Combinaison de plasmids)
            prod_array = VirusProduction.where(:plasmid_tag => @production.cbtag)
            @vps = prod_array.pluck(:number).sort.join(',')
            
            @trigger = prod_array.count
      
            unless @production.clone_batches.empty?
              if @trigger >= 1
                flash.keep[:warning] = "You did this before! This combination of plasmids already exists (virus # #{@vps}) . Are you sure you want to do it again?"
              else
               flash.discard(:success) 
               flash[:success] = "Task completed."                
             end
            end
            
     else
        flash[:notice] = "Add plasmids please."  
        render :action => :new
     end
 end
 
 def edit
   @production.update_columns(:step => 0)
 end
 
 def update
      @projects_all = Project.all
      @production.update_attributes(production_params)
     if @production.valid?
            redirect_to @production
            @production.update_columns(:step => 0)
            update_last_step(@production, 0)
            @production.update_columns(:percentage => 10)
            
            @production.update_columns(:cbtag => @production.clone_batches.order(:nb).pluck(:nb).join(" "))
            
            #Recherche de doublons (Combinaison de plasmids)
            prod_array = VirusProduction.where(:plasmid_tag => @production.cbtag)
            @vps = prod_array.pluck(:number).sort.join(',')
            @trigger = prod_array.count
      
            unless @production.clone_batches.empty?
              if @trigger > 1
                flash.discard(:success)
                flash[:success] = "Task completed."
                flash.keep[:warning] = "You did this before! This combination of plasmids already exists (virus # #{@vps}). Are you sure you want to do it again?"
              else
               flash.discard(:success) 
               flash[:success] = "Task completed."                
             end
            end
            
      else
       flash[:notice] = "Add plasmids please."  
       render :action => :edit
     end 

  end
  
  def show
    redirect_to :action => :add_plasmid
  end

  def add_plasmid
      @clone_batches = @production.plasmid_batches.order(:id).map {|object| object.clone_batch}
      #
       @production.update_columns(:step => 1)
       unless @production.clone_batches.empty?
       
       @production.update_columns(:percentage => 50)
       
       if @production.plasmid_batches.nil?
         @production.update_columns(:last_step => 1)
       elsif @production.plasmid_batch_productions.where(:volume=>0).any?
         @production.update_columns(:last_step => 1)
       end
       #
      end
  end
  
  def select_pbs
      @plasmids = PlasmidBatch.where(:trash => false).where('volume > ?', 0)
  end
  
  def add_pbs
    @production.update_attributes(production_params)
    
    pbs = @production.plasmid_batches
    pbtag_value = pbs.order(:name).pluck(:id).sort.join('-')
    @production.update_columns(:pbtag => pbtag_value)
    
    flash.discard[:success]
    flash.discard[:warning]
     
        @production.update_columns(:step => 0)
        @production.update_columns(:percentage => 40)
        @production.update_columns(:pbtag => @production.plasmid_batches.order(:name).pluck(:name).join(" "))
        
    #Recherche de l'existence d'une combinaison de plasmid_batches identique dans la DB
            
            prod_array = VirusProduction.where(:plasmid_batch_tag => @production.pbtag)
            @vps = prod_array.pluck(:number).sort.join(',')
            @trigger = prod_array.count
            
            unless @production.plasmid_batches.empty?
              if @trigger >= 1
                flash.keep[:alert] = "You did this before! This combination of plasmid batches already exists (virus # #{@vps}). Are you sure you want to do it again?"
              else
               flash.now[:success] = "Task completed." 
             end
            end
   end
   
   def reset_volume
     @production.plasmid_batches.each do |pb|
       pb.plasmid_batch_productions.where(:production_id => @production.id).first.update_columns(:volume => 0)
     end
      @production.update_column(:last_step => 1)
   end
   
   def pool
     #
     @production = Production.find(params[:production_id])
     #
     @production.update_attributes(production_params)
   end
   
    def set_pb_volume
    end
  
  def update_pb_volume
    @production.update_attributes(production_volumes_params)

      if @production.valid?
        flash.keep[:success] = "Task completed!"
        
        #Actuallisation des volumes de chaque plasmid batch
            @production.plasmid_batch_productions.each do |pbp|
              remaining_volume = pbp.starting_volume - pbp.volume
              pbp.plasmid_batch.update_columns(:volume => remaining_volume)
            end
            
        #Actualisation du status de la production au cas ou un volume serait égal à zéro
        if @production.plasmid_batch_productions.where(:volume=>0).any?
          @production.update_column(:last_step => 1)
        end
        
      else
        render :action => 'set_pb_volume'
     end
  end
 
  def virus_production
    #Collection des plasmids batches
    @plasmid_batches = @production.plasmid_batches.order(:id)
    
    #@production.plasmid_batch_productions.each do |pbp|
    # remaining_volume = pbp.starting_volume - pbp.volume
    # pbp.plasmid_batch.update_columns(:volume => remaining_volume)
    # end
    
    #Collection de virus (en fait un virus seulement par production)
    @vps = @production.virus_productions
    
    #
    @plasmids = PlasmidBatch.all
      #
    
      @arr1= (@production.plasmid_batches.map{|pb| pb.clone_batch.id}).sort
      @arr2= @production.clone_batches.pluck(:id).sort
      
      @a = @arr2 - @arr1
      @str = CloneBatch.where(:id => @a).pluck(:name).sort.to_sentence
      @missing_plasmids = 'batch'.pluralize(@a.size)+' for '+@str+"."
      
    if !@a.empty?
      flash.keep[:warning] = "Add each  corresponding plasmid batches please: missing #@missing_plasmids"
      redirect_to :action => :add_plasmid
    elsif @production.plasmid_batch_productions.any? { |pbp| pbp.volume <= 0 }
      flash.keep[:warning] = "Complete the  production volumes, please."
      redirect_to :action => :add_plasmid
    elsif @production.plasmid_batches.any? { |pb| pb.volume.nil? }
       flash.keep[:warning] = "Check the production volumes, please."
      redirect_to :action => :add_plasmid
    else
      @production.update_columns(:step => 2)
        update_last_step(@production, 2)
        @production.update_columns(:percentage => 75)
    end
    
  end
  
  def spawn_vp
    @production = Production.find(params[:production_id])
    #Ligne suivante indispensable pour nested_form
      @production.virus_productions.build
      @vps = @production.virus_productions
      @last_virus = VirusProduction.all.last
  end
  
 def destroy
  pbs = @production.plasmid_batches
  @production.plasmid_batch_productions.each do |pbp|
    pb = pbs.where(:id => pbp.plasmid_batch_id).last
    backward_volume = pb.volume + pbp.volume
    pb.update_columns(:volume => backward_volume)
  end
  @production.destroy
  @productions = Production.where.not(:last_step => 3).rank(:row_order).all
  redirect_to :action => 'index'
 end
  
 def create_vp
     #production_vp_params doit contenir production_id dans les attribut de virus_production (nested)
     #Sinon impossible d'ajouter nouveau virus_production
     @production.update_attributes(production_vp_params)
     @vps = @production.virus_productions
     @vp_last = @vps.last
             
     if @production.valid?
       @production.virus_productions.each do |vp|
         vp.update_columns(:number => vp.nb.to_s)
       end
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
    if @production.virus_productions.empty?
      flash.keep[:notice] = "Add at least one virus please."
      redirect_to :action => :virus_production
    else
      @production.update_columns(:step => 3)
      update_last_step(@production, 3)
      @production.update_columns(:percentage => 100)
      redirect_to :action => :index
    #
      inform_closed_production    
    end
 end
 
  def inform_closed_production
    @production = Production.find(params[:id])
    production = @production 
    ProductionNotifier.notify_closed_production(@production).deliver_now
    flash.keep[:success] = "Production closed. A mail has been sent to the administrators!"
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
      
      #
      @projects_all = Project.all.order(name: "asc").uniq
      @projects_all = @projects_all.map{ |obj| [obj['name'], obj['id']] }
      
      #
      @clone_batches_all = CloneBatch.all.order(name: "asc")
      
      #          
      @q = Production.ransack(params[:q])
      @productions = @q.result(distinct: true).includes(:projects, :clone_batches)
      
      #Config de l'affichage des résultats.
      @productions = smart_listing_create(:productions, @productions, partial: "productions/smart_listing/list", default_sort: {id: "asc"}, page_sizes: [ 10, 20, 30, 50, 100])  
  end
  
  def scheduler
    
    @productions = Production.all.where.not(:last_step => 3)
      
    gon.rabl "app/views/productions/scheduler.json.rabl", as: "productions"

  end
  

  private
  
  def set_production
    @production = Production.find(params[:id])
       #
   rescue ActiveRecord::RecordNotFound  
    redirect_to :controller => "virus_productions", :action => "index"
    flash[:alert] = "Production not found."
   return
   
  end

  def production_params
    params.require(:production).permit(:id, :order_date, :production_id, :name, :display, :step, :comment, :created_at , :updated_at , :row_order_position, :locked, :percentage, :pool, :cbtag, :pbtag,
    :disable_switch,
    project_ids: [],
    :projects_attributes => [:id, :name],
    :clone_batches_attributes => [:id, :name, :_destroy],
    :plasmid_batches_attributes => [:id, :name, :_destroy, :volume],
    :plasmid_batch_productions_attributes => [:id, :name, :_destroy, :volume, :starting_volume],
    clone_batch_ids: [],
    plasmid_batch_ids: [],
    :assay_attributes => [:id, :name],
    :virus_production_attributes => [:id, :number, :production_id, :date_order, :date_production, :user_id, :plate_name, :vol, :sterility, :plate_id, :titer_atcc, :titer, :titer_to_atcc, :comment,
    :gel_prot, :invoice, :bach_end, :l2, :hek_result, :created_at, :updated_at, :vol_unit_id,
    :dosages_attributes => [:id, :virus_production_id, :titer, :titer_atcc, :titer_to_atcc, :date, :user_id, :_destroy, :inactivation]],
    virus_production_ids: []
    )
  end
  
    def production_create_params
      params.require(:production).permit(:order_date, :production_id, :name, :display, :step, :comment, :created_at , :updated_at , :row_order_position, :locked, :percentage, :pool, :cbtag, :pbtag,
      project_ids: [],
      :projects_attributes => [:id, :name],
      :clone_attributes => [:id, :name, :assay_id],
      :clone_batches_attributes => [:id, :name, :_destroy ],
      :assay_attributes => [:id, :name],
      :plasmid_batches_attributes => [:id, :name, :_destroy],
      :plasmid_batch_productions_attributes => [:id, :name, :_destroy, :volume, :starting_volume],
      plasmid_batch_ids: [],
      clone_batch_ids: []
    )
  end
  
    def production_projects_params
    params.require(:production).permit(:id, :production_id,
    project_ids: [],
    :projects_attributes => [:id, :name],
    
    )
  end
    
  def production_vp_params
    params.require(:production).permit(:id,
    :virus_productions_attributes => [:id, :nb, :number, :user_id, :plate_name, :vol, :sterility, :plate_id, :titer_atcc, :titer, :titer_to_atcc, :comment, :date_of_production,
    :gel_prot, :invoice, :l2, :hek_result, :created_at, :updated_at, :vol_unit_id, :production_id, :plasmid_tag, :plasmid_batch_tag, :rev_plasmid_tag, :rev_plasmid_batch_tag, :genes_tag, :promoters_tag,
    :dosages_attributes => [:id, :virus_production_id, :titer, :titer_atcc, :titer_to_atcc, :date, :user_id, :_destroy, :inactivation]])
  end
  
  def production_OLD_volumes_params
    params.require(:production).permit(:id, 
      :plasmid_batches_attributes => [:id, :volume, :_destroy,
        :plasmid_batch_productions_attributes => [:id, :volume, :production_id, :plasmid_batch_id, :_destroy ]]
    )
  end
  
   def production_volumes_params
    params.require(:production).permit(:id, 
        :plasmid_batch_productions_attributes => [:id, :volume, :starting_volume, :production_id, :plasmid_batch_id, :_destroy ]
    )
  end
  
  def production_position_params
    params.permit(:id, :row_order_position)
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

