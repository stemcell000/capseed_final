class PcrColoniesController < ApplicationController
 before_action :set_params, only:[:update, :create, :create_pcr_colony_protocol_collection]
  before_action :load_clone_batch, only:[ :new, :create, :destroy, :set_pcr_colony_validation, :set_pcr_colony_unvalidation]
  before_action :load_pcr_colony, only:[:update, :destroy, :load_all, :set_pcr_colony_validation, :set_pcr_colony_unvalidation]
  before_action :load_all, only:[:create, :update, :destroy,  :new_pcr_colony_protocol, :create_pcr_colony_protocol_collection, :set_pcr_colony_validation, :set_pcr_colony_unvalidation]
  after_action :batch_pcr_colony_validation_checking, only:[:destroy]
  before_filter :load_users, only:[:edit, :new, :update, :create, :new_pcr_colony_protocol]
  
  def edit
    @assay = Assay.find(params[:assay_id])
    @pcr_colony = PcrColony.find(params[:id])
    #@pcr_colony.qc_attachments.build
    @clone = Clone.find(params[:clone_id])
    @clone_batch = CloneBatch.find(params[:clone_batch_id])
  end
  
  def new
    @pcr_colony = @clone_batch.pcr_colonies.new
    #@pcr_colony.qc_attachments.build
    @clone_batch = CloneBatch.find(params[:clone_batch_id])
    @clone = Clone.find(params[:clone_id])
    @assay = Assay.find(params[:assay_id])
  end
  
  def create
    @pcr_colony = PcrColony.create(set_params)
    if @pcr_colony.valid?
        @clone_batch.pcr_colonies << @pcr_colony
        batch_pcr_colony_validation_checking
    else
        render :action => :new
    end
  end
  
  def update
    #TUTO: Indispensable de placer load_all en before action pour update si on veut passer les instances de variable comme @clone dans le js.erb (n° de balise).
    @pcr_colony.update_attributes(set_params)
    if @pcr_colony.valid?
      batch_pcr_colony_validation_checking
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @pcr_colony.destroy
  end

  
  def new_pcr_colony_protocol
    @pcr_colony =  PcrColony.new
    @pcr_colony.qc_attachments.build
    
    respond_to do |format|
        format.js
        format.html
      end
  end
  
  def create_pcr_colony_protocol_collection
    
   #TUTO:Génération du pcr_colony modèle (jamais enregistré)
    @pcr_colony = PcrColony.new(set_params)
    if @pcr_colony.valid?
           @clone.clone_batches.each do |cb|
    #TUTO:Duplication totale (+association) sauf attachement
              cbseq = @pcr_colony.amoeba_dup
    #TUTO:association des attachement du pcr_colony modèle
              @pcr_colony.qc_attachments.each do |a|
                cbseq.qc_attachments << a
              end
              cb.pcr_colonies << cbseq
          end
        flash.keep[:success] = "Task completed!"
        batch_pcr_colony_validation_checking
      else
        @users = User.all.order(:lastname)
        render :action => :new_pcr_colony_protocol
      end
  end
  
  def set_pcr_colony_validation
    @pcr_colony = PcrColony.find(params[:id])
    @pcr_colony.update_columns(:conclusion => true)
    #TUTO:indispensable pour exécuter le fichier js.erb correspondant
    respond_to do |format|
      format.js
      format.html
    end
  end
  
   def set_pcr_colony_unvalidation
    @pcr_colony = PcrColony.find(params[:id])
    @pcr_colony.update_columns(:conclusion => false)
    #TUTO:indispensable pour exécuter le fichier js.erb correspondant
    respond_to do |format|
      format.js {render :set_pcr_colony_validation}
      format.html
    end
  end
  
  private
    def set_params
      params.require(:pcr_colony).permit(:clone_batch_id, :id, :name, :primer_f, :primer_r, :user_id, :date, :comment, :result, :conclusion,
      :clone_batch_attributes => [:name, :comment, :qc_validation, :clone_batch_id, :clone_id],
      :qc_attachments_attributes =>[:id,:pcr_colony_id, :attachment, :remove_attachment, :_destroy],
      :clone_attributes => [:id, :name, :clone_id],
      :assay_attributes => [:id, :name, :assay_id])
    end
      
    def load_clone_batch 
      @clone_batch = CloneBatch.find(params[:clone_batch_id])
    end
    
    def load_pcr_colony
      @pcr_colony = PcrColony.find(params[:id])
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
    
    def batch_pcr_colony_validation_checking
      if @clone_batch
         if @clone_batch.pcr_colonies.any? {|s| s.conclusion == true}
           @clone_batch.update_columns(:qc_validation => true)
         else
          @clone_batch.update_columns(:qc_validation => false)
          end
        end
    end  
end
