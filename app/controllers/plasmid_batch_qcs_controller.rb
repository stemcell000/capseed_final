class PlasmidBatchQcsController < InheritedResources::Base
  
  before_action :set_params, only:[:create, :update ]
  before_action :load_plasmid_batch_qc, only:[ :edit, :destroy, :update ]
  before_action :load_all, only:[ :new, :edit, :create, :update, :destroy, :new_qc_protocol, :create_qc_protocol_collection, :set_qc_validation, :set_qc_unvalidation]
  before_filter :load_users, only:[:edit, :new, :update, :create, :new_qc_protocol, :create_qc_protocol_collection]
  before_action :load_plasmid_batch, only:[:batch_qc_validation_checking]

def new
    @plasmid_batch_qc = PlasmidBatchQc.new
    @plasmid_batch_qc.plasmid_batch_qc_attachments.build
    #Indispensable pour transmettre @plasmid_batch à batch_qc_validation_checking et actualidation après fermeture de la fenêtre modal:
    @plasmid_batch = PlasmidBatch.find(params[:plasmid_batch_id])
end

def create
  @plasmid_batch_qc = PlasmidBatchQc.create(set_params)
  #Indispensable pour transmettre @plasmid_batch à batch_qc_validation_checking et actualidation après fermeture de la fenêtre modal:
  @plasmid_batch = PlasmidBatch.find(params[:plasmid_batch_id])
    if @plasmid_batch_qc.valid?
      @plasmid_batch.plasmid_batch_qcs << @plasmid_batch_qc
      flash.keep[:success] = "Task completed!"
    else
      render :action => 'new'
    end
end

def edit
  @plasmid_batch_qc.plasmid_batch_qc_attachments.build
  #Indispensable pour transmettre @plasmid_batch à batch_qc_validation_checking et actualidation après fermeture de la fenêtre modal:
  @plasmid_batch = PlasmidBatch.find(params[:plasmid_batch_id])
end

 def update
    @plasmid_batch_qc.update_attributes(set_params)
    @plasmid_batch = PlasmidBatch.find(params[:plasmid_batch_id])
    #Indispensable pour transmettre @plasmid_batch à batch_qc_validation_checking et actualidation après fermeture de la fenêtre modal:
     @plasmid_batch = PlasmidBatch.find(params[:plasmid_batch_id])
    if @plasmid_batch_qc.valid?
      batch_qc_validation_checking(@plasmid_batch)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
   #Indispensable pour transmettre @plasmid_batch à batch_qc_validation_checking et actualidation après fermeture de la fenêtre modal:
    @plasmid_batch = PlasmidBatch.find(params[:plasmid_batch_id])
    @plasmid_batch_qc.destroy
    #Actualisation du statut des clone_patch /plasmides
           @clone_batch.plasmid_batches.where.not(:name => nil).each do |pb|
             pb_qc = @plasmid_batch_qc.dup
              batch_qc_validation_checking(pb)
          end
    
  end
  
   def new_qc_protocol
    @plasmid_batch_qc =  PlasmidBatchQc.new
      respond_to do |format|
        format.js
        format.html
      end
    end
  
   def create_qc_protocol_collection
    @plasmid_batch_qc = PlasmidBatchQc.new(set_params)

    if @plasmid_batch_qc.valid?
      
           @clone_batch.plasmid_batches.each do |pb|
             
             #Duplication totale (+association) sauf attachement
              pbqc = @plasmid_batch_qc.amoeba_dup
              
               #association des attachement du QC modèle
                @plasmid_batch_qc.plasmid_batch_qc_attachments.each do |a|
                  pbqc.plasmid_batch_qc_attachments << a
                end
                
             pb.plasmid_batch_qcs << pbqc
            
            end
          
      else
        @users = User.all.order(:lastname)
        render :action => :new_qc_protocol
      end
  end
  
  
    def set_qc_validation
      @plasmid_batch_qc = PlasmidBatchQc.find(params[:id])
      @plasmid_batch_qc.update_columns(:conclusion => true)
      #TUTO:indispensable pour exécuter le fichier js.erb correspondant
      respond_to do |format|
        format.js
      end 
    end
    
     def set_qc_unvalidation
      @plasmid_batch_qc = PlasmidBatchQc.find(params[:id])
      @plasmid_batch_qc.update_columns(:conclusion => false)
      #TUTO:indispensable pour exécuter le fichier js.erb correspondant
      respond_to do |format|
        format.js {render :set_qc_validation}
      end
    end
  

  private

    def set_params
      params.require(:plasmid_batch_qc).permit(:dig_other, :comments, :conclusion, :plasmid_batch_id , :sma1_id, :user_id, :sma1_display,:_destroy, :primer1, :primer2, :date_send,
      :plasmid_batch_attributes => [:clone_batch_id, :id, :format, :concentration, :comment, :unit_id],
      :clone_batch_attributes => [:id, :name, :promoted, :comment, :qc_validation, :clone_batch_id, :clone_id],
      :clone_attributes => [:id, :name, :assay_id],
      :assay_attributes => [:id, :name],
      :plasmid_batch_qc_attachments_attributes =>[:id,:plasmid_batch_qc_id, :attachment, :remove_attachment, :_destroy],
      :sma1_attributes => [:id, :name],
      :user_attributes => [:id, :username, :firstname, :lastname, :full_name]
      )
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
    
    def load_plasmid_batch_qc
      @plasmid_batch_qc = PlasmidBatchQc.find(params[:id])
    end
    
    def load_plasmid_batch
      @plasmid_batch = PlasmidBatch.find(params[:plasmid_batch_id])
    end
    
    def batch_qc_validation_checking(plasmid_batch)
        if plasmid_batch.plasmid_batch_qcs.any? {|qc| qc.conclusion == true}
          plasmid_batch.update_columns(:qc_validation => true)
        else
          plasmid_batch.update_columns(:qc_validation => false)
        end
    end
    
    def load_users
      @users = User.all.order(:lastname)
    end
end

