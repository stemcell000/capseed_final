class ProductionsController < InheritedResources::Base
  
  before_action :ranked_productions, only: [:index]
  before_action :production_params, only:[:create, :update_row_order, :update]
  before_action :set_production, only:[:edit, :update, :add_plasmid_batch, :virus_production]
  
#Smart_listing
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper 
  
  def index
    @productions =Production.rank(:row_order).all
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
    #redirect_to @production
    redirect_to :action => :add_plasmid_batch
          @production.update_columns(:step => 0)
          @production.update_columns(:percentage => 25)
  else
    render :action => 'edit'
  end
  end
  
  def show
    #@plasmid_batches = @production.plasmid_batches.order(:id)
    redirect_to :action => :add_plasmid_batch
  end

  def add_plasmid_batch
    @plasmid_batches = @production.plasmid_batches.order(:id)
    @production.update_columns(:step => 1)
    update_last_step(@production, 1)
    @production.update_columns(:percentage => 50)
  end
 
  def virus_production
    @plasmid_batches = @production.plasmid_batches.order(:id)
      if @plasmid_batches.empty?
        flash.keep[:notice] = "Add a plasmid, please."
        redirect_to :action => :add_plasmid_batch
      else
        @plasmid_batches = @production.plasmid_batches.order(:id)
        @production.update_columns(:step => 2)
        update_last_step(@production, 2)
        @production.update_columns(:percentage => 75)
      end
  end
  
  def display_all
    #"between search": recherche dans un range de dates
      params[:q] ||= {}
          
          if params[:q][:created_at_gteq].present?
            params[:q][:created_at_gteq] = reformatdate(params[:q][:created_at_gteq])
          end
          
          if params[:q][:created_at_lteq].present?
            params[:q][:created_at_lteq] = reformatdate(params[:q][:created_at_lteq])
          end
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
      @productions = smart_listing_create(:productions, @productions, partial: "productions/smart_listing/list", default_sort: {name: "asc"}, page_sizes: [ 10, 20, 30, 50, 100])  

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
      params.require(:production).permit(:id, :production_id, :name, :display, :step, :comment, :created_at , :updated_at , :row_order_position, :plasmid_batch_id, :locked, :percentage,
      project_ids: [],  plasmid_ids: [],
      :projects_attributes => [:id, :name],
      :plasmid_batches_attributes => [:clone_batch_id, :id, :production_id, :format, :concentration, :comment, :unit_id , :box_id, :row_id, :column_id, :strict_validation ,:_destroy,
      :plasmid_batch_attachments_attributes =>[:id,:plasmid_batch_id, :attachment, :remove_attachment, :_destroy],
      :clone_batch_attributes => [:id, :name, :promoted, :comment, :qc_validation, :clone_batch_id, :clone_id],
      :clone_attributes => [:id, :name, :assay_id],
      :assay_attributes => [:id, :name],
      :unit_attributes =>[:id, :plasmid_batch_id, :name],
      :plasmid_batch_qcs_attributes =>[:id, :plasmid_batch_id, :dig_saml, :dig_other, :itr, :comments, :conclusion]]
      )
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

