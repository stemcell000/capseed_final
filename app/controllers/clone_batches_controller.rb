class CloneBatchesController < InheritedResources::Base
  
  #Smart_listing
    include SmartListing::Helper::ControllerExtensions
    helper  SmartListing::Helper
    
  autocomplete :clone_batch, :name
    
  before_filter :authenticate_user!
  before_action :set_clone_batch, only:[ :edit, :show_exist, :select, :destroy, :add_plasmid_batch, :add_pb_from_inventory, :update,
    :edit_from_inventory, :update_from_inventory, :update_pb_from_inventory, :destroy_from_inventory, :edit_as_plasmid,
    :update_as_plasmid, :remove_plasmid_data, :edit_from_prod, :remove_from_prod, :select_from_prod, :add_to_prod]
  before_action :load_all, only:[:select, :update, :update_as_plasmid, :update_plasmid_batch, :add_plasmid_batch, :destroy]
  before_action :load_assay, only:[:show_exist, :select]
  before_action :load_clone, only:[:show_exist, :select, :update_as_plasmid]
  before_action :load_lists, only: [:edit_as_plasmid, :edit_from_inventory, :new_from_inventory, :update_from_inventory, :update_as_plasmid]

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
    @clone = Clone.find(params[:clone_id])
    @assay = Assay.find(params[:assay_id])
  end
  
  def update
    @clone_batch.skip_batch_validation = true
    #@clone_batch.skip_type_validation = true
    @clone_batch.skip_strict_validation = true
    
    @clone_batch.attributes = clone_batch_params
    if @clone_batch.save(validate: false)
      if @clone_batch.name.blank?
        remove_plasmid_data
      end
        flash.keep[:success] = "Task completed!"
      else
        render :action => 'edit'
      end
  end
  
  def update_as_plasmid
      @clone_batch.update_attributes(plasmid_params)
      if @clone_batch.valid?
        flash.keep[:success] = "Task completed!"
         #
         if @clone_batch.insert.nil?
          @insert = Insert.new(:name => @clone_batch.name, :number => @clone_batch.nb.to_s)
          @clone_batch.insert = @insert
         end
         #
        else
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
    #effacement des données de plasmid uniquement
    @clone_batch.update_columns(:strand_id =>nil , :date_as_plasmid=>nil,
                                :glyc_stock_box_as_plasmid=>nil, :origin_id=>nil, :type_id=>nil, 
                                :comment_as_plasmid=>nil, :number => nil, :nb => nil)
    #destruction des associations
    @clone_batch.clone_batch_as_plasmid_attachments.each do |cba|
      cba.update_columns(:attachment => nil)
    end
    @clone_batch.clone_batch_attachments.destroy_all
    @clone_batch.genes.destroy_all
    @clone_batch.promoters.destroy_all
    @clone_batch.plasmid_batches.destroy_all
    #destruction de l'insert correspondant
    @clone_batch.insert.destroy
  end
  
  
  #INVENTORY
  
   def index
    #Formattage des dates
        start_time = params[:created_at_gteq].to_date rescue Date.current
        start_time = start_time.beginning_of_day # sets to 00:00:00
        end_time = params[:created_at_lteq].to_date rescue Date.current
        end_time = end_time.end_of_day # sets to 23:59:59
      
      @option = current_user.options.first
      
      #Recherche sur tables multiples.
        @q = CloneBatch.ransack(params[:q])
        
    #Champ targets
      @targets_all = Target.all.order(name: "asc").uniq
      @targets_all = @targets_all.map{ |obj| [obj['name'], obj['id']] }
    #Champs types
      @types_all = Type.all.order(name: "asc").uniq
      @types_all = @types_all.map{ |obj| [obj['name'], obj['id']] }
    #Champs genes
      @genes_all = Gene.all.order(name: "asc").uniq
      @genes_all = @genes_all.map{ |obj| [obj['name'], obj['id']] }
     #Champs promoters
      @promoters_all = Promoter.all.order(name: "asc").uniq
      @promoters_all = @promoters_all.map{ |obj| [obj['name'], obj['id']] }
     #Champs origins
      @origins_all = Origin.all.order(name: "asc").uniq
      @origins_all = @origins_all.map{ |obj| [obj['name'], obj['id']] }
      
    #variable global utilisé par la méthode 'listing' pour eviter l'initialisation de la recherche à la fermeture de la fenêtre modale (edit-from-inventory)
      @clone_batches = @q.result.includes(:clone, :target, :type, :strand, :genes, :promoters, :origin, :plasmid_batches).where.not(:nb => nil)
      
    #Config de l'affichage des résultats.
      @all_clone_batches = smart_listing_create(:clone_batches, @clone_batches, partial: "clone_batches/smart_listing/list", default_sort: {nb: "desc"}, page_sizes: [20,30, 50, 100])  
  
    respond_to do |format|
      format.html
      format.text
      format.js
      format.csv { send_data @clone_batches.to_csv }
      format.xls
    end
    
  end
  
  
  def edit_from_inventory
      @clone_batch.skip_name_validation = false
      @clone_batch.skip_type_validation = false
    if @clone_batch.genes.empty?
      @units = Unit.all
      @users = User.all
   end
      @clone_batch.update_columns(:strict_validation => 1, :plasmid_validation => 1, :inventory_validation => 1)
  end
  
  def update_from_inventory
    @clone_batch.update_columns(:strict_validation => 0, :plasmid_validation => 0)
    @clone_batch.skip_name_validation = false
    @clone_batch.skip_type_validation = false
    @clone_batch.update_attributes(plasmid_params)
    
    insert = @clone_batch.insert
   unless insert.nil?
      insert.update_attributes(:name => @clone_batch.name, :number => @clone_batch.number, :dismissed => @clone_batch.dismissed)
   end
  end
  
  def add_pb_from_inventory
    @units = Unit.all
    @users = User.all
    @clone_batch.plasmid_batches.build
    @clone_batch.update_columns(:strict_validation => 0, :plasmid_validation => 0)
    @plasmid_batches = @clone_batch.plasmid_batches
    
  end
  
  
  def update_pb_from_inventory
    
    @clone_batch.update_attributes(plasmid_pb_params)
    @users = User.all
    
    if @clone_batch.valid?
        redirect_to  root_path

     else
       
        render action: :add_pb_from_inventory
    end
    
  end
  
   def destroy_from_inventory
     @clone_batch = CloneBatch.find(params[:id])
     @clone_batches = CloneBatch.all
     @clone_batch.destroy
     @clone_batch.insert.destroy
   end
   
   def new_from_inventory
    @clone_batch = CloneBatch.new
    @clone_batch.clone_batch_attachments.build
    @clone_batch.skip_name_validation = false
    @clone_batch.skip_type_validation = false
   end
   
   def create_from_inventory
    @clone_batch = CloneBatch.create(plasmid_params)
    
      if params[:clone_id]
        @clone_batch = CloneBatch.find(params[:clone_id])
      end
      #
      if  @clone_batch.valid?
          @clone_batch.update_columns(:strict_validation => 0)
          if @clone
            @clone.clone_batches << @clone_batch
          end
          @insert = Insert.new(:name => @clone_batch.name, :number => @clone_batch.number, :dismissed => @clone_batch.dismissed)
          @clone_batch.insert = @insert
          flash.keep[:success] = "Task completed!"
      else
          render :action => :new_from_inventory
      end
  end
  
  private
  
    def set_clone_batch
      @clone_batch = CloneBatch.find(params[:id])
    end
    
    def clone_batch_params
      params.require(:clone_batch).permit(:id, :name, :number, :comment, :qc_validation, :clone_id, :assay_id, :plasmid_validation, :temp_name, :type_id, :dismissed, :nb,
      :clone_batch_attachments_attributes =>[:id,:clone_batch_id, :attachment, :remove_attachment, :_destroy],
      :clone_batch_as_plasmid_attachments_attributes =>[:id,:clone_batch_id, :attachment, :remove_attachment, :_destroy],
      
      :plasmid_batches_attributes => [:id, :clone_batch_id, :number, :name, :volume, :format, :concentration, :comment, :unit_id , :vol_unit_id, :box_id, :row_id, :column_id, :production_id, :format_id,
      :user_id, :strict_validation, :_destroy,
      :plasmid_batch_attachments_attributes =>[:id,:plasmid_batch_id, :attachment, :remove_attachment, :_destroy]],
      
      :clone_attributes => [:id, :name, :assay_id],
      :assay_attributes => [:id, :name],
      :type_attributes => [:id, :name],
      :insert_attributes => [:id, :name, :number, :clone_batch_id, :dismissed],
      :productions_attributes => [:id]
      )
      
    end
    
    def plasmid_params
      
      params.require(:clone_batch).permit(:id, :name, :number, :qc_validation, :clone_batch_id, :clone_id, :origin_id, :strand_id, :type_id, :assay_id, :plasmid_validation, :target_id ,:_destroy,
      :strand_id, :date_as_plasmid, :glyc_stock_box_as_plasmid, :comment_as_plasmid, :production_id, :template, :temp_name, :nb, :dismissed, :hidden,
      
      :clone_batch_as_plasmid_attachments_attributes =>[:id,:clone_batch_id, :attachment, :remove_attachment, :_destroy],
     
      :plasmid_batches_attributes => [:id, :name, :clone_batch_id, :comment, :concentration, :user_id, :box_id, :row_id, :column_id, :unit_id, :format_id, :_destroy,
      :plasmid_batch_attachments_attributes =>[:id,:plasmid_batch_id, :attachment, :remove_attachment, :_destroy]],
      
      :clone_attributes => [:id, :name, :assay_id, :clone_id],
      :assay_attributes => [:id, :name ],
      :type_attributes => [:id, :name ],
      :insert_attributes => [:id, :name, :number ],
      :strand_attributes => [:id, :name ],
      :origin_attributes => [:id, :name],
      :genes_attributes => [:id, :name],
      :promoters_attributes => [:id, :name],
      :user_attributes => [:id, :username, :firstname, :lastname, :full_name, :_destroy],
      :box_attributes => [:id, :name],
      :row_attributes => [:id, :name],
      :column_attributes => [:id, :name],
      gene_ids: [], promoter_ids: [],
      :productions_attributes => [:id])
    end
    
    def plasmid_pb_params
      params.require(:clone_batch).permit(:id, :name, :number, :qc_validation, :clone_batch_id, :clone_id, :type_id, :assay_id, :strand_id, :origin_id, :plasmid_validation, :target_id ,:_destroy,
      :strand_id, :date_as_plasmid, :glyc_stock_box_as_plasmid,:comment_as_plasmid, :production_id, :template, :temp_name, :nb, :dismissed,
      
      :clone_batch_as_plasmid_attachments_attributes =>[:id,:clone_batch_id, :attachment, :remove_attachment, :_destroy],
     
      :type_attributes => [:id, :name],
      :insert_attributes => [:id, :name, :number, :clone_batch_id],
      :strand_attributes => [:id, :name],
      :origin_attributes => [:id, :name],
      :genes_attributes => [:id, :name, :clone_batch_id, :_destroy],
      :promoters_attributes => [:id, :name, :clone_batch_id, :_destroy],
      :user_attributes => [:id, :username, :firstname, :lastname, :full_name, :_destroy],
      :box_attributes => [:id, :name],
      :row_attributes => [:id, :name],
      :column_attributes => [:id, :name],
      :sequencing_attributes => [:name, :primer, :user_id, :date_rec, :date_send, :comment, :result, :conclusion],
      :pcr_colony_attributes => [:name, :primer_r, :primer_f, :user_id, :date, :comment, :result, :conclusion],
      gene_ids: [], promoter_ids: [], sequencing_ids: [], pcr_colonies: [])
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
    
    def load_lists
      @strands_all = Strand.all
      @types_all = Type.all.order(:name)
      @targets_all = Target.all.order(:name)
      @genes_all = Gene.all.order(:name)
      @promoters_all = Promoter.all.order(:name)
      @origins_all = Origin.all.order(:name)
    end
    
    def get_clone_batches_scope
      clone_batches_scope = CloneBatch.all
      clone_batches_scope = CloneBatch.search(params[:number]) if params[:number].present?
      clone_batches_scope
    end
    
end

