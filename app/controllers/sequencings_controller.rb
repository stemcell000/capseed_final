class SequencingsController < ApplicationController
  
  before_action :set_params, only:[:update, :create, :create_sequencing_protocol_collection]
  before_action :load_clone_batch, only:[ :new, :create, :destroy, :set_sequencing_validation, :set_sequencing_unvalidation]
  before_action :load_sequencing, only:[:update, :destroy, :load_all, :set_sequencing_validation, :set_sequencing_unvalidation]
  before_action :load_all, only:[:create, :update, :destroy,  :new_sequencing_protocol, :create_sequencing_protocol_collection, :set_sequencing_validation, :set_sequencing_unvalidation]
  after_action :batch_sequencing_validation_checking, only:[:destroy]
  before_filter :load_users, only:[:edit, :new, :update, :create, :new_sequencing_protocol]
  
  def edit
    @assay = Assay.find(params[:assay_id])
    @sequencing = Sequencing.find(params[:id])
    @clone = Clone.find(params[:clone_id])
    @clone_batch = CloneBatch.find(params[:clone_batch_id])
  end
  
  def new
    @sequencing = @clone_batch.sequencings.new
    @clone_batch = CloneBatch.find(params[:clone_batch_id])
    @clone = Clone.find(params[:clone_id])
    @assay = Assay.find(params[:assay_id])
  end
  
  def create
    @sequencing = Sequencing.create(set_params)
    if @sequencing.valid?
        @clone_batch.sequencings << @sequencing
        batch_sequencing_validation_checking
    else
        render :action => :new
    end
  end
  
  def update
    #TUTO: Indispensable de placer load_all en before action pour update si on veut passer les instances de variable comme @clone dans le js.erb (n° de balise).
    @sequencing.update_attributes(set_params)
    if @sequencing.valid?
      batch_sequencing_validation_checking
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @sequencing.destroy
  end

  
  def new_sequencing_protocol
    @sequencing =  Sequencing.new
    
    respond_to do |format|
        format.js
        format.html
      end
  end
  
  def create_sequencing_protocol_collection
    
   #TUTO:Génération du sequencing modèle (jamais enregistré)
    @sequencing = Sequencing.new(set_params)
    if @sequencing.valid?
            @clone.clone_batches.each do |cb|
    #TUTO:Duplication totale (+association) sauf attachement
            cbseq = @sequencing.amoeba_dup
    #TUTO:association des attachement du sequencing modèle
           @sequencing.qc_attachments.each do |a|
                cbseq.qc_attachments << a
            end
              cb.sequencings << cbseq
          end
        flash.keep[:success] = "Task completed!"
        batch_sequencing_validation_checking
      else
        @users = User.all.order(:lastname)
        render :action => :new_sequencing_protocol
      end
  end
  
  def set_sequencing_validation
    @sequencing = Sequencing.find(params[:id])
    @sequencing.update_columns(:conclusion => true)
    #TUTO:indispensable pour exécuter le fichier js.erb correspondant
    respond_to do |format|
      format.js
      format.html
    end
  end
  
   def set_sequencing_unvalidation
    @sequencing = Sequencing.find(params[:id])
    @sequencing.update_columns(:conclusion => false)
    #TUTO:indispensable pour exécuter le fichier js.erb correspondant
    respond_to do |format|
      format.js {render :set_sequencing_validation}
      format.html
    end
  end
  
  private
    def set_params
      params.require(:sequencing).permit(:clone_batch_id, :id, :name, :user_id, :date_rec, :date_send, :comment, :result, :conclusion,
      :clone_batch_attributes => [:name, :comment, :qc_validation, :clone_batch_id, :clone_id],
      :qc_attachments_attributes =>[:id,:sequencing_id, :attachment, :remove_attachment, :_destroy],
      :clone_attributes => [:id, :name, :clone_id],
      :assay_attributes => [:id, :name, :assay_id],
      :primers_attributes => [:id, :name, :sequence, :sequencing_id],
      primer_ids: [])
    end
      
    def load_clone_batch 
      @clone_batch = CloneBatch.find(params[:clone_batch_id])
    end
    
    def load_sequencing
      @sequencing = Sequencing.find(params[:id])
    end
    
    def load_all
        @clone = Clone.find(params[:clone_id])
        @assay = Assay.find(params[:assay_id]) 
        @clones = @assay.clones
        @clone_batches = @clone.clone_batches
        @primers = Primer.all
    end
    
    def load_users
      @users = User.all.order(:lastname)
    end
    
    def batch_sequencing_validation_checking
      if @clone_batch
         if @clone_batch.sequencings.any? {|s| s.conclusion == true}
           @clone_batch.update_columns(:qc_validation => true)
         else
          @clone_batch.update_columns(:qc_validation => false)
          end
        end
    end
end
