class CloneBatchQcsController < InheritedResources::Base
  
  before_action :set_params, only:[:update, :create, :create_qc_protocol_collection]
  before_action :load_clone_batch, only:[ :new, :create, :destroy, :set_qc_validation, :set_qc_unvalidation]
  before_action :load_qc, only:[:update, :destroy, :load_all, :set_qc_validation, :set_qc_unvalidation]
  before_action :load_all, only:[:create, :update, :destroy,  :new_qc_protocol, :create_qc_protocol_collection, :set_qc_validation, :set_qc_unvalidation]
  after_action :batch_qc_validation_checking, only:[:destroy]
  before_filter :load_users, only:[:edit, :new, :update, :create, :new_qc_protocol, :render_sequencing, :render_pcr_colony]
  
  def edit
    @assay = Assay.find(params[:assay_id])
    @clone_batch_qc = CloneBatchQc.find(params[:id])
    @clone_batch_qc.clone_batch_qc_attachments.build
    @clone = Clone.find(params[:clone_id])
    @clone_batch = CloneBatch.find(params[:clone_batch_id])
    @primers_all = Primer.all
  end
  
  def new
    @clone_batch_qc = @clone_batch.clone_batch_qcs.new
    @clone_batch_qc.clone_batch_qc_attachments.build
    @clone_batch = CloneBatch.find(params[:clone_batch_id])
    @clone = Clone.find(params[:clone_id])
    @assay = Assay.find(params[:assay_id])
    @primers_all = Primer.all
  end
  
  def create
    @clone_batch_qc = CloneBatchQc.create(set_params)
    if @clone_batch_qc.valid?
        @clone_batch.clone_batch_qcs << @clone_batch_qc
        flash.keep[:success] = "Task completed!"
        batch_qc_validation_checking
        @clone_batch = @clone_batch_qc.clone_batch
      else
        render :action => :new
      end
  end
  
  def update
    #TUTO: Indispensable de placer load_all en before action pour update si on veut passer les instances de variable comme @clone dans le js.erb (n° de balise).
    @clone_batch_qc.update_attributes(set_params)
    if @clone_batch_qc.valid?
      flash.keep[:success] = "Task completed!"
      batch_qc_validation_checking
      @clone_batch = @clone_batch_qc.clone_batch
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @clone_batch_qc.destroy
  end
  
  def new_qc_protocol
    @clone_batch_qc =  CloneBatchQc.new
    @primers_all = Primer.all
    
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def render_sequencing
    @clone_batch_qc =  CloneBatchQc.new
  end
  
  def render_pcr_colony
    @clone_batch_qc =  CloneBatchQc.new
  end
  
  def create_qc_protocol_collection
    @clone_batch_qc = CloneBatchQc.new(set_params)
    if @clone_batch_qc.valid?
           @clone.clone_batches.each do |cb|
             cb_qc = @clone_batch_qc.dup
             cb_qc.save
              cb.clone_batch_qcs << cb_qc
           end
        flash.keep[:success] = "Task completed!"
        batch_qc_validation_checking
      else
        @users = User.all.order(:lastname)
        render :action => :new_qc_protocol
      end
  end
  
  def set_qc_validation
    @clone_batch_qc = CloneBatchQc.find(params[:id])
    @clone_batch_qc.update_columns(:conclusion => true)
    #TUTO:indispensable pour exécuter le fichier js.erb correspondant
    respond_to do |format|
      format.js
    end
  end
  
   def set_qc_unvalidation
    @clone_batch_qc = CloneBatchQc.find(params[:id])
    @clone_batch_qc.update_columns(:conclusion => false)
    #TUTO:indispensable pour exécuter le fichier js.erb correspondant
    respond_to do |format|
      format.js {render :set_qc_validation}
    end
  end
  
  private
    def set_params
      params.require(:clone_batch_qc).permit(:clone_batch_id, :id, :user_id, :primer_id, :pcr_colony_id, :sequencing_id, :date_send, :date_rec, :result, :conclusion,
      :clone_batch_attributes => [:name, :promoted, :comment, :qc_validation, :clone_batch_id, :clone_id],
      :clone_batch_qc_attachments_attributes =>[:id,:clone_batch_qc_id, :attachment, :remove_attachment, :_destroy],
      :clone_attributes => [:id, :name, :clone_id],
      :assay_attributes => [:id, :name, :assay_id],
      :primer_attributes => [:id, :name, :number],
       users_ids: [],
       primers_ids: [],
      :user_attributes => [:id, :username, :firstname, :lastname, :full_name],
      :pcr_colony_attributes => [:id, :name],
      :sequencing_attributes => [:id, :name])
    end
      
    def load_clone_batch 
      @clone_batch = CloneBatch.find(params[:clone_batch_id])
    end
    
    def load_qc
      @clone_batch_qc = CloneBatchQc.find(params[:id])
    end
    
    def load_all
        @clone = Clone.find(params[:clone_id])
        @assay = Assay.find(params[:assay_id]) 
        @clones = @assay.clones
        @clone_batches = @clone.clone_batches
    end
    
    def load_users
      @users = User.all.order(:lastname)
    end
    
    def batch_qc_validation_checking
      if @clone_batch
         if @clone_batch.clone_batch_qcs.any? {|qc| qc.conclusion == true}
           @clone_batch.update_columns(:qc_validation => true)
         else
          @clone_batch.update_columns(:qc_validation => false)
          end
        end
    end

end

