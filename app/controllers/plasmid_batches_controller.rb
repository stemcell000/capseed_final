class PlasmidBatchesController < ApplicationController

autocomplete :plasmid_batch, :number, :extra_data => [:id, :name], :display_value => :autocomplete_display

  before_action :set_params, only:[:create, :add_to_prod, :create_from_inventory]
  before_action :load_plasmid_batch, only:[ :edit, :edit_from_inventory, :destroy, :update, :update_from_inventory, :send_to_production,:destroy_from_inventory, :destroy_confirm, :update_and_sort, :remove_box_row_column,
                                            :load_box, :load_row, :load_column, :edit_to_prod, :add_to_prod,:send_to_production, :show ]
  before_action :load_all, only:[ :edit, :edit_and_sort, :destroy, :create, :destroy_from_list]
  before_action :load_all_for_close, only:[ :update_and_sort, :load_box, :load_row, :load_column, :remove_box_row_column]
  before_action :load_all_for_prod, only:[ :edit_to_prod ]
  before_filter :listing, only: [:update_from_inventory, :edit_from_inventory, :create_from_inventory, :destroy_from_inventory]
  before_action :load_users, only: [:new, :new_from_inventory, :edit, :create, :update] 
  before_filter :load_batches, only:[:update_from_inventory, :send_to_production]
  
#Smart_listing
    include SmartListing::Helper::ControllerExtensions
    helper  SmartListing::Helper

def new
    @plasmid_batch = PlasmidBatch.new
    @clone_batch = CloneBatch.find(params[:clone_batch_id])
    @clone = Clone.find(params[:clone_id])
    @assay = Assay.find(params[:assay_id])
    @number = @clone_batch.plasmid_batches.length + 1
    @name = @name = @clone_batch.number+"."+@number.to_s
end


def new_from_inventory
    @plasmid_batch = PlasmidBatch.new
    @user = User.all
    @clone_batch = CloneBatch.find(params[:clone_batch_id])
    @number = @clone_batch.plasmid_batches.length + 1
    @boxes = Box.all
    @columns = Column.all
    @rows = Row.all
    @name = @clone_batch.number+"."+@number.to_s
end

  
def create
    @plasmid_batch = PlasmidBatch.create(set_params)

    if  @plasmid_batch.valid?
        @plasmid_batch.update_columns(:strict_validation => 0)
        @clone_batch.plasmid_batches << @plasmid_batch
        flash.keep[:success] = "Task completed!"
    else
        render :action => 'new'
    end
end

def create_from_inventory
    @plasmid_batch = PlasmidBatch.create(set_params)
    @users = User.all
    @clone_batch = CloneBatch.find(params[:clone_batch_id])
    if  @plasmid_batch.valid?
        @plasmid_batch.update_columns(:strict_validation => 0)
        @clone_batch.plasmid_batches << @plasmid_batch
        flash.keep[:success] = "Task completed!"
        @plasmid_batches = @clone_batch.plasmid_batches
    else
        render :action => 'new_from_inventory'
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
  @users = User.all
  @boxes = Box.all
  @columns = Column.all
  @rows = Row.all
  @virus_list = @plasmid_batch.productions.pluck(:id).to_s
end
  
def update
  @plasmid_batch.update_attributes(set_params)
  if @plasmid_batch.valid?
    @clone_batch = CloneBatch.find(@plasmid_batch.clone_batch_id)
    @units = Unit.all
    unless @plasmid_batch.plasmid_batch_productions.empty?
      @plasmid_batch.plasmid_batch_productions.update_all(:starting_volume => @plasmid_batch.volume)
    end
    flash.keep[:success] = "Task completed!"
  else
    render :action => 'edit'
  end
end
  
def update_from_inventory
  @plasmid_batch.update_attributes(set_params)
  if @plasmid_batch.valid?
    @units = Unit.all
     unless @plasmid_batch.plasmid_batch_productions.empty?
    @plasmid_batch.plasmid_batch_productions.update_all(:starting_volume => @plasmid_batch.volume) 
    end
    @plasmid = @plasmid_batch.clone_batch
    flash.keep[:success] = "Task completed!"
    redirect_to add_pb_from_inventory_clone_batch_path(:id => @plasmid.id)
  else
    render :action => 'edit_from_inventory'
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
      @row = @plasmid_batch.row
      @column = @plasmid_batch.column
       @row.plasmid_batches.delete(@plasmid_batch) unless @row.nil?
       @column.plasmid_batches.delete(@plasmid_batch) unless @column.nil?
      end
      flash.keep[:success] = "Task completed!"
    else
      render :action => 'edit_and_sort'
    end
  end
  
  def destroy_from_list
    
    @plasmid_batch = PlasmidBatch.find(params[:id])
    @clone_batch = CloneBatch.find(params[:clone_batch_id])
    @plasmid_batches = @clone_batch.plasmid_batches
    @plasmid_batch.toggle!(:trash)
    garbage = Box.find_by_name("Garbage")
    
    unless @plasmid_batch.trash
      @plasmid_batch.update_columns(:volume => 0)
      garbage.plasmid_batches << @plasmid_batch
     else
      garbage.plasmid_batches.delete(@plasmid_batch)
     end
      
     @row = @plasmid_batch.row
      @column = @plasmid_batch.column
      if @row 
        @row.plasmid_batches.delete(@plasmid_batch)
      end
      if @column
        @column.plasmid_batches.delete(@plasmid_batch)
      end
  end
  
  def destroy_from_inventory
    @clone_batch = CloneBatch.find(params[:clone_batch_id])
    @plasmid_batches = @clone_batch.plasmid_batches
    @plasmid_batch.toggle!(:trash)
    
    garbage = Box.find_by_name("Garbage")
    
    if @plasmid_batch.trash
      @plasmid_batch.update_columns(:volume => 0)
      @plasmid_batch.plasmid_batch_productions.update_all(:starting_volume => @plasmid_batch.volume)
      garbage.plasmid_batches << @plasmid_batch
     else
      garbage.plasmid_batches.delete(@plasmid_batch)
     end
     
      @row = @plasmid_batch.row
      @column = @plasmid_batch.column
      if @row 
        @row.plasmid_batches.delete(@plasmid_batch)
      end
      if @column
        @column.plasmid_batches.delete(@plasmid_batch)
      end
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
    
  def show
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
  
  def set_volume
    @plasmid_batch = PlasmidBatch.find(params[:id])
  end
  
  def update_pb_volume
    @plasmid_batch = PlasmidBatch.find(params[:id])
    @plasmid_batch.update_attributes(set_params)
    
    if @plasmid_batch.valid?
      flash.keep[:success] = "Task completed!"
    else
      render :action => 'edit_pb_volume'
    end
  end
  
  private
    def set_params
      params.require(:plasmid_batch).permit(:clone_batch_id, :id, :number, :name, :volume, :format, :concentration, :comment, :unit_id , :vol_unit_id, :box_id, :row_id, :column_id, :production_id, :format_id,
      :user_id, :strict_validation , :_destroy, :trash, :date,
      
      :plasmid_batch_attachments_attributes =>[:id,:plasmid_batch_id, :attachment, :remove_attachment, :_destroy],
      
      :clone_attributes => [:id, :name, :assay_id],
      
      :assay_attributes => [:id, :name],
      
      :vol_unit_attributes =>[:id, :plasmid_batch_id, :name],
      
      :plasmid_batch_qcs_attributes =>[:id, :dig_saml, :dig_other, :comments, :conclusion],
      
      :productions_attributes => [:id, :name, :_destroy],
       production_ids: [],
      
      :box_attributes => [:id, :name],
      
      :row_attributes => [:id, :name],
      
      :column_attributes => [:id, :name],
      
      :format_attributes => [:id, :name],
      
      :user_attributes => [:id, :username, :firstname, :lastname, :full_name])
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
    
    def NameFormatHelper(str)
      str = format('%05d', str)
      puts "str="+str
    return str
   end
   
   def set_search
    @search=PlasmidBatch.search(params[:q])
   end
   
    def load_users
      @users = User.all.order(:lastname)
    end
    
    def load_batches
      @clone_batch = CloneBatch.find(@plasmid_batch.clone_batch_id)
      @plasmid_batches = @clone_batch.plasmid_batches
    end

end

