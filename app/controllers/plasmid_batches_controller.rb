class PlasmidBatchesController < ApplicationController

autocomplete :plasmid_batch, :number, :extra_data => [:id, :name], :display_value => :autocomplete_display

  before_action :set_params, only:[:create, :add_to_prod, :create_from_inventory]
  before_action :load_plasmid_batch, only:[ :edit, :edit_from_inventory, :destroy, :update, :update_from_inventory, :destroy_from_inventory, :destroy_confirm, :update_and_sort, :remove_box_row_column, :load_box, :load_row, :load_column, :edit_to_prod, :add_to_prod ]
  before_action :load_all, only:[ :edit, :edit_and_sort, :update, :destroy, :create]
  before_action :load_all_for_close, only:[ :update_and_sort, :load_box, :load_row, :load_column, :remove_box_row_column]
  before_action :load_all_for_prod, only:[ :edit_to_prod ]
  before_action :load_production, only:[ :add_to_prod, :remove_from_prod ]
  before_filter :listing, only: [:update_from_inventory, :edit_from_inventory, :create_from_inventory, :destroy_from_inventory]
  
#Smart_listing
    include SmartListing::Helper::ControllerExtensions
    helper  SmartListing::Helper

def new
    @plasmid_batch = PlasmidBatch.new
    @plasmid_batch.plasmid_batch_attachments.build
    @clone_batch = CloneBatch.find(params[:clone_batch_id])
    @clone = Clone.find(params[:clone_id])
    @assay = Assay.find(params[:assay_id])
    nb = @clone_batch.plasmid_batches.length+1
    @name = @clone_batch.id+"."+nb.to_s
end

def new_from_inventory
    @plasmid_batch = PlasmidBatch.new
    @plasmid_batch.plasmid_batch_attachments.build
end
  
def create
    @plasmid_batch = PlasmidBatch.create(set_params)

    if  @plasmid_batch.valid?
        @plasmid_batch.update_columns(:strict_validation => 0)
        @plasmid_batch.update_columns(:number => @plasmid_batch.id.to_s)
        @clone_batch.plasmid_batches << @plasmid_batch
        flash.keep[:success] = "Task completed!"
    else
        render :action => :new
    end
end

def create_from_inventory
  
    @plasmid_batch = PlasmidBatch.create(set_params)
    if params[:clone_batch_id]
      @clone_batch = CloneBatch.find(params[:clone_batch_id])
    end

    if  @plasmid_batch.valid?
        @plasmid_batch.update_columns(:strict_validation => 0)
        @plasmid_batch.update_columns(:number => @plasmid_batch.id.to_s)
        if @clone_batch
          @clone_batch.plasmid_batches << @plasmid_batch
        end
        flash.keep[:success] = "Task completed!"
    else
        render :action => :new_from_inventory
    end
end

def edit
  @plasmid_batch.plasmid_batch_attachments.build
  @units = Unit.all
  @current_url = request.original_url
end

def edit_from_inventory
  @plasmid_batch.plasmid_batch_attachments.build
  @units = Unit.all
  @plasmid_batch.update_columns(:inventory_validation => 1)
end
  
def update
  @plasmid_batch.update_attributes(set_params)
  if @plasmid_batch.valid?
    @clone_batch = CloneBatch.find(@plasmid_batch.clone_batch_id)
    @units = Unit.all
    flash.keep[:success] = "Task completed!"
  else
    render :action => 'edit'
  end
end
  
def update_from_inventory
  @plasmid_batch.update_attributes(set_params)
  if @plasmid_batch.valid?
    @units = Unit.all
    flash.keep[:success] = "Task completed!"
  else
    render :action => 'edit'
   end
   
   
end 

 ##Permettre d'indiquer la boite et les coordonnées du tube 
  def edit_and_sort
      @plasmid_batch = PlasmidBatch.find(params[:id])
  end
  
  def update_and_sort
    @plasmid_batch.update_attributes(set_params)
   if @plasmid_batch.valid?
      box = Box.find(@plasmid_batch.box_id)
      if box.name == "Garbage"
      @row = Row.find(@plasmid_batch.row_id)
      @column = Column.find(@plasmid_batch.column_id)
       @row.plasmid_batches.delete(@plasmid_batch)  
       @column.plasmid_batches.delete(@plasmid_batch)
      end
      flash.keep[:success] = "Task completed!"
    else
      render :action => 'edit_and_sort'
    end
  end
  
  def destroy
    @plasmid_batches = @clone_batch.plasmid_batches.all
    @plasmid_batch = PlasmidBatch.find(params[:id])
    @plasmid_batch.destroy
  end
  
  def destroy_from_inventory
    @plasmid_batch.delete
  end
  
  #Interaction avec production
  def select_to_prod
    if params[:id]
        @plasmid_batch = PlasmidBatch.find(params[:id])
        @format = @plasmid_batch.format
        @unit = @plasmid_batch.unit
        @box = @plasmid_batch.box
        @row = @plasmid_batch.row
        @column = @plasmid_batch.column
        @vol_unit = @plasmid_batch.vol_unit
        @plasmid_batch_attachments = @plasmid_batch.plasmid_batch_attachments
        @clone_batch = @plasmid_batch.clone_batch
        @clone = Clone.find(@clone_batch.clone_id)
        @assay = Assay.find(@clone.assay_id)
        @clone_batch_attachments = @clone_batch.clone_batch_attachments
        @clone_attachments = @clone.clone_attachments
        @clone_batch_as_plasmid_attachments = @clone_batch.clone_batch_as_plasmid_attachments
        @projects = @assay.projects
        @inserts = @clone.inserts
      render :action => 'edit_to_prod'
    else
      @plasmid_batch = PlasmidBatch.new
      @clone_batch = @plasmid_batch.clone_batch
    end
  end
  
  def edit_to_prod
    if params[:id]
        @plasmid_batch = PlasmidBatch.find(params[:id])
     else
       render :action => 'select_to_prod'
    end
  end
  
  def add_to_prod
    @plasmid_batch = PlasmidBatch.find(params[:id])
    if @plasmid_batch.valid?
      @plasmid_batches = @production.plasmid_batches
      @plasmid_batches << @plasmid_batch
         flash.keep[:success] = "Task completed!"
     else
      render :action => 'edit_to_prod'
     end
        
  end
  
  def remove_from_prod
    plasmid_batch = PlasmidBatch.find(params[:plasmid_batch_id])
    @plasmid_batches = @production.plasmid_batches
    @plasmid_batches.delete(plasmid_batch)
    #rendu d'un fichier javascript pour actualiser le tableau des plasmid_batches, une fois la suppression effectué.
    #(on utilise le même fichier que lorsqu'on ajoute un plasmid batch.)
    respond_to do |format|
      format.js { render :action => "add_to_prod" }
    end
  end
  
  def add_virus_prod
     plasmid_batch = PlasmidBatch.find(params[:plasmid_batch_id])
     @plasmid_batches = @production.plasmid_batches
  end
  
  def show
    #@plasmid_batches = @production.plasmid_batches.order(:id)
  end
  
  def index
    
    #Formattage des dates
      start_time = params[:created_at_gteq].to_date rescue Date.current
      start_time = start_time.beginning_of_day # sets to 00:00:00
      end_time = params[:created_at_lteq].to_date rescue Date.current
      end_time = end_time.end_of_day # sets to 23:59:59
    
    #Recherche sur tables multiples.
      @q = PlasmidBatch.ransack(params[:q])
      
    #variable global utilisé par la méthode 'listing' pour eviter l'initialisation de la recherche à la fermeture de la fenêtre modale (edit-from-inventory)
      $p = @q
      @plasmid_batches = @q.result.includes(:clone_batch)
      
    #Config de l'affichage des résultats.
    @plasmid_batches = smart_listing_create(:plasmid_batches, @plasmid_batches, partial: "plasmid_batches/smart_listing/list", default_sort: {id: "asc"}, page_sizes: [10, 20, 30, 50, 100])  
  
  end
  
   def listing
    
    @q = PlasmidBatch.ransack(params[:q])
      if $p
      @plasmid_batches = $p.result.includes(:clone_batch)
      else
        @plasmid_batches = @q.result.includes(:clone_batch)
      end 
    #Config de l'affichage des résultats.
    @plasmid_batches = smart_listing_create(:plasmid_batches, @plasmid_batches, partial: "plasmid_batches/smart_listing/list", default_sort: {number: "asc"}, page_sizes: [10, 20, 30, 50, 100])  
  end
  
  private
    def set_params
      params.require(:plasmid_batch).permit(:clone_batch_id, :id, :number, :name, :volume, :format, :concentration, :comment, :unit_id , :vol_unit_id, :box_id, :row_id, :column_id, :production_id, :format_id, :strict_validation ,:_destroy,
      :plasmid_batch_attachments_attributes =>[:id,:plasmid_batch_id, :attachment, :remove_attachment, :_destroy],
      :clone_batch_attributes => [:id, :name, :promoted, :comment, :qc_validation, :clone_id],
      :clone_attributes => [:id, :name, :assay_id],
      :assay_attributes => [:id, :name],
      :vol_unit_attributes =>[:id, :plasmid_batch_id, :name],
      :plasmid_batch_qcs_attributes =>[:id, :plasmid_batch_id, :dig_saml, :dig_other, :itr, :comments, :conclusion],
      :production_attributes => [:id, :name, :plasmid_batch_id],
      :box_attributes => [:id, :name],
      :row_attributes => [:id, :name],
      :column_attributes => [:id, :name],
      :format_attributes => [:id, :name])
    end
      
    def load_all 
        @clone_batch = CloneBatch.find(params[:clone_batch_id])
        @clone = Clone.find(params[:clone_id])
        @assay = Assay.find(params[:assay_id])
        @clones = @assay.clones.all
        @cb_collection = []
        @clones.each do |c|
          @cb_collection = c.clone_batches.where.not(:name => nil).order(:id) + @cb_collection
        end
    end
    
    def load_all_for_close
      @clone_batch = CloneBatch.find(@plasmid_batch.clone_batch_id)
      @clone = Clone.find(@clone_batch.clone_id)
      @assay = Assay.find(@clone.assay_id)
      @cb_collection = []
      @clones = @assay.clones.order(:id)
      @clones.each do |c|
      @cb_collection = c.clone_batches.where.not(:name => nil).order(:id) + @cb_collection
      end
    end
    
    def load_all_for_prod 
      @clone_batch = CloneBatch.find(@plasmid_batch.clone_batch_id)
      @clone = Clone.find(@clone_batch.clone_id)
      @assay = Assay.find(@clone.assay_id)
      @clones = @assay.clones
    end
    
    def load_box
      @box = Box.find(@plasmid_batch.box_id)
    end
    
    def load_plasmid_batch
      @plasmid_batch = PlasmidBatch.find(params[:id])
    end
    
    def load_production
      @production = Production.find(params[:production_id])
    end
    
    def NameFormatHelper(str)
      str = format('%05d', str)
      puts "str="+str
    return str
   end
   
   def set_search
    @search=PlasmidBatch.search(params[:q])
   end

end

