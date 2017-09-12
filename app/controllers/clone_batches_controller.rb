class CloneBatchesController < InheritedResources::Base
  
  autocomplete :clone_batch, :name, :extra_data => [:id], :scopes => [:plasmid_allow]
  
  before_action :set_params, only:[ :edit, :edit_from_inventory, :update_from_inventory, :show_exist, :select, :destroy, :destroy_from_inventory, :add_plasmid_batch, :update, :edit_as_plasmid, :update_as_plasmid, :remove_plasmid_data]
  before_action :load_all, only:[:select, :update, :update_as_plasmid, :update_plasmid_batch, :add_plasmid_batch, :destroy]
  before_action :load_assay, only:[:show_exist, :select]
  before_action :load_clone, only:[:show_exist, :select, :update_as_plasmid]
  before_action :index, only: [:update_from_inventory, :edit_from_inventory, :create_from_inventory, :destroy_from_inventory]
  
  #Smart_listing
    include SmartListing::Helper::ControllerExtensions
    helper  SmartListing::Helper
  
  def edit
    @clone_batch = CloneBatch.find(params[:id])
    @clone = Clone.find(params[:clone_id])
    @assay = Assay.find(params[:assay_id])
  end
  
  def new
      @clone = Clone.find(params[:clone_id])
      @clone_batch = CloneBatch.find(params[:clone_batch_id])
  end
  
  
  def edit_as_plasmid
    @clone_batch.clone_batch_as_plasmid_attachments.build 
    @units = Unit.all
    @clone = Clone.find(params[:clone_id])
    @assay = Assay.find(params[:assay_id])
  end
  
  def update
    CloneBatch.skip_callback(:update) 
    @clone_batch.update_attributes(clone_batch_params)
    @clone = Clone.find(params[:clone_id])
    @clone_batches = @clone.clone_batches
      if @clone_batch.valid?
        flash.keep[:success] = "Task completed!"
        CloneBatch.set_callback(:create)
      else
        render :action => 'edit'
      end
  end
  
  def update_as_plasmid
      @clone_batch.update_attributes(clone_batch_params)
      @units = Unit.all
      if @clone_batch.valid?
        flash.keep[:success] = "Task completed!"
         #
         if @clone_batch.insert.nil?
          @insert = Insert.new(:name => @clone_batch.name, :number => @clone_batch.id)
          @clone_batch.insert = @insert
         end
         #
        else
        @units = Unit.all
        render :action => 'edit_as_plasmid'
      end
  end
  
  def destroy
    @insert = Insert.where(:clone_batch_id => params[:id])
    @insert.destroy
    @clone_batches = @clone.clone_batches.all
    @clone_batch = CloneBatch.find(params[:id])
    @clone_batch.destroy
  end
  
  def remove_from_clone_collection
    @clone_batch = CloneBatch.find(params[:id])
    @clone = Clone.find(params[:clone_id])
    @assay = Assay.find(params[:assay_id])
    @cb_collection = @clone.clone_batches
    @cb_collection.delete(@clone_batch)
  end
  
  def add_plasmid_batch
    @units = Unit.all
    @clone_batch.plasmid_batches.build
  end
  
  def update_plasmid_batch
    @clone_batch.update_attributes(clone_batch_params)
     if @clone_batch.valid?
      flash.keep[:success] = "Task completed!"
    else
      @units = Unit.all
      render :action => 'add_plasmid_batch'
    end
  end
  
  def remove_plasmid_data
    @clone_batch = CloneBatch.find(params[:id])
    @clone = Clone.find(params[:clone_id])
    @assay = Assay.find(params[:assay_id])
    #effacement des données de plasmide uniquement
    @clone_batch.update_columns(:strand_as_plasmid =>nil , :date_as_plasmid=>nil,
                                :glyc_stock_box_as_plasmid=>nil, :origin_as_plasmid=>nil, :type_id=>nil, 
                                :comment_as_plasmid=>nil, :promoter_as_plasmid=>nil, :gene_as_plasmid=>nil)
    #destruction des documents associés
    @clone_batch.clone_batch_as_plasmid_attachments.each do |cba|
      cba.update_columns(:attachment => nil)
    end
    #destruction de l'insert correspondant
    @insert = Insert.where(:clone_batch_id => params[:id])
    @insert.destroy
  end
  
  
  #Inventaire
  
  def index
    
    #Formattage des dates
      start_time = params[:created_at_gteq].to_date rescue Date.current
      start_time = start_time.beginning_of_day # sets to 00:00:00
      end_time = params[:created_at_lteq].to_date rescue Date.current
      end_time = end_time.end_of_day # sets to 23:59:59
    
    #Recherche sur tables multiples.
      @q = CloneBatch.ransack(params[:q])
      
    #variable global utilisé par la méthode 'listing' pour eviter l'initialisation de la recherche à la fermeture de la fenêtre modale (edit-from-inventory)
      $p = @q
      @clone_batches = @q.result.includes(:clone, :plasmid_batches).where.not(:name => nil)
      
    #Config de l'affichage des résultats.
      @clone_batches = smart_listing_create(:clone_batches, @clone_batches, partial: "clone_batches/smart_listing/list", default_sort: {id: "asc"}, page_sizes: [10, 20, 30, 50, 100, 500])  
  
  end
  
  
   def listing 
    @q = CloneBatch.ransack(params[:q])
      if $p
      @clone_batches = $p.result.includes(:clone, :plasmid_batches).where.not(:name => nil)
      else
        @clone_batches = @q.result.includes(:clone, :plasmid_batches).where.not(:name => nil)
      end 
    #Config de l'affichage des résultats.
    @clone_batches = smart_listing_create(:clone_batches, @clone_batches, partial: "clone_batches/smart_listing/list", default_sort: {name: "asc"}, page_sizes: [10, 20, 30, 50, 100, 500])  
  end
  
  def edit_from_inventory
  end
  
  def update_from_inventory
   @clone_batch.update_attributes(clone_batch_params)
    if @clone_batch.valid?
      flash.keep[:success] = "Task completed!"
    else
      render :action => 'edit_from_inventory'
     end
    end
   
   def destroy_from_inventory
     @clone_batch = CloneBatch.find(params[:id])
     @clone_batches = CloneBatch.all
     @clone_batch.destroy
   end
   
   def new_from_inventory
    @clone_batch = CloneBatch.new
    @clone_batch.clone_batch_attachments.build
   end
   
   def create_from_inventory
  
    @clone_batch = CloneBatch.create(clone_batch_params)
    if params[:clone_id]
      @clone_batch = CloneBatch.find(params[:clone_id])
    end

    if  @clone_batch.valid?
        @clone_batch.update_columns(:strict_validation => 0)
        if @clone
          @clone.clone_batches << @clone_batch
        end
        flash.keep[:success] = "Task completed!"
    else
        render :action => :new_from_inventory
    end
end
  
  private
  
    def set_params
      @clone_batch = CloneBatch.find(params[:id])
    end
    
    def clone_batch_params
      params.require(:clone_batch).permit(:id, :name, :comment, :qc_validation, :clone_batch_id, :clone_id, :type_id, :assay_id, :plasmid_validation, :_destroy,
      :strand_as_plasmid, :date_as_plasmid, :glyc_stock_box_as_plasmid, :origin_as_plasmid, :type_as_plasmid, :comment_as_plasmid, :promoter_as_plasmid, :gene_as_plasmid,
      :clone_batch_qc_attributes => [:primer_nb, :primer_name, :date_send, :date_rec, :rec_name, :result, :conclusion],
      :clone_batch_attachments_attributes =>[:id,:clone_batch_id, :attachment, :remove_attachment, :_destroy],
      :clone_batch_as_plasmid_attachments_attributes =>[:id,:clone_batch_id, :attachment, :remove_attachment, :_destroy],
      :plasmid_batches_attributes => [:name, :format, :concentration, :_destroy, :id, :clone_batch_id, :unit_id, :unit_attributes =>[:id, :plasmid_batch_id, :name]],
      :clone_attributes => [:id, :name, :assay_id],
      :assay_attributes => [:id, :name],
      :type_attributes => [:id, :name],
      :insert_attributes => [:id, :name, :number, :clone_batch_id])
    end
    
    def plasmid_params
      params.require(:clone_batch).permit(:id, :name, :qc_validation, :clone_batch_id, :clone_id, :type_id, :assay_id, :plasmid_validation, :_destroy,
      :strand_as_plasmid, :date_as_plasmid, :glyc_stock_box_as_plasmid, :origin_as_plasmid, :type_as_plasmid, :comment_as_plasmid, :promoter_as_plasmid, :gene_as_plasmid,
      :clone_batch_qc_attributes => [:primer_nb, :primer_name, :date_send, :date_rec, :rec_name, :result, :conclusion],
      :clone_batch_as_plasmid_attachments_attributes =>[:id,:clone_batch_id, :attachment, :remove_attachment, :_destroy],
      :plasmid_batches_attributes => [:name, :format, :concentration, :_destroy, :id, :clone_batch_id, :unit_id, :unit_attributes =>[:id, :plasmid_batch_id, :name]],
      :clone_attributes => [:id, :name, :assay_id],
      :assay_attributes => [:id, :name],
      :type_attributes => [:id, :name],
      :insert_attributes => [:id, :name, :number, :clone_batch_id])
      
    end
    
    def load_all
        @clone_batch = CloneBatch.find(params[:id])
        @clone = Clone.find(params[:clone_id])
        @assay = Assay.find(params[:assay_id]) 
        @clones = @assay.clones
        @cb_collection = []
        @clones.each do |c|
          @cb_collection = c.clone_batches.where.not(:name => nil).order(:id) + @cb_collection
        end
    end
    
    def load_assay
      @assay = Assay.find(params[:assay_id])
    end
    
    def load_clone
      @clone = Clone.find(params[:clone_id])
    end
   
end

