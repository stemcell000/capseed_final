class CloneBatchQcsController < InheritedResources::Base
  before_action :set_params, only:[:update, :create]
  before_action :load_clone_batch, only:[ :edit, :new, :update, :create, :destroy]
  before_action :load_qc, only:[:update, :destroy, :edit, :load_all]
  before_action :load_all, only:[:update, :create, :destroy]
  after_action :batch_qc_validation_checking, only:[:destroy]
  before_action :load_users, only:[:edit, :new, :update, :create]
  
  
  def edit
    @clone_batch_qc.clone_batch_qc_attachments.build
    
  end
  
  def new
    @clone_batch_qc = @clone_batch.clone_batch_qcs.new
    @clone_batch_qc.clone_batch_qc_attachments.build
    @clone_batch = CloneBatch.find(params[:clone_batch_id])
    @clone = Clone.find(params[:clone_id])
    @assay = Assay.find(params[:assay_id])
  end
  
  def create
    @clone_batch_qc = CloneBatchQc.create(set_params)
    if @clone_batch_qc.valid?
        @clone_batch.clone_batch_qcs << @clone_batch_qc
        flash.keep[:success] = "Task completed!"
        batch_qc_validation_checking
      else
        render :action => :new
      end
  end
  
  def update
    @clone_batch_qc.update_attributes(set_params)
    if @clone_batch_qc.valid?
      flash.keep[:success] = "Task completed!"
      batch_qc_validation_checking
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @clone_batch_qc.destroy
  end
  
  private
    def set_params
      params.require(:clone_batch_qc).permit(:clone_batch_id, :id, :user_id, :primer_nb, :primer_name, :date_send, :date_rec, :result, :conclusion,
      :clone_batch_attributes => [:name, :promoted, :comment, :qc_validation, :clone_batch_id, :clone_id],
      :clone_batch_qc_attachments_attributes =>[:id,:clone_batch_qc_id, :attachment, :remove_attachment, :_destroy],
      :clone_attributes => [:id, :name, :assay_id],
      :assay_attributes => [:id, :name],
       users_ids: [],
      :user_attributes => [:id, :username, :firstname, :lastname, :full_name])
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
      if @clone_batch.clone_batch_qcs.any? {|qc| qc.conclusion == true}
        @clone_batch.update_columns(:qc_validation => true)
      else
        @clone_batch.update_columns(:qc_validation => false)
      end
    end

end

