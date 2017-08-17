class PlasmidBatchQcsController < InheritedResources::Base
  
  before_action :set_params, only:[:create, :update ]
  before_action :load_plasmid_batch_qc, only:[ :edit, :destroy, :update ]
  before_action :load_all, only:[ :new, :edit, :create, :update, :destroy]

def new
    @plasmid_batch_qc = PlasmidBatchQc.new
    @plasmid_batch_qc.plasmid_batch_qc_attachments.build
end

def create
  @plasmid_batch_qc = PlasmidBatchQc.create(set_params)
      if @plasmid_batch_qc.valid?
        batch_qc_validation_checking
        puts case @plasmid_batch_qc.pcr_colony_id
        when 1
          @plasmid_batch.plasmid_batch_qcs << @plasmid_batch_qc
          flash.now[:success] = "QC added!"
        when 2
          flash.now[:info] = "Do the PCR Colony again, please."
        when 3
          flash.now[:info] = "Do the PCR Colony, please."
        else
          @plasmid_batch.plasmid_batch_qcs << @plasmid_batch_qc
          flash.now[:success] = "QC added! (althought, the PCR Colony was done...)"
          @plasmid_batch_qc.update_columns(:conclusion => true)
        end
      else
        render :action => :new
      end
end

def edit
  @plasmid_batch_qc.plasmid_batch_qc_attachments.build
end

 def update
    @plasmid_batch_qc.update_attributes(set_params)
    if @plasmid_batch_qc.valid?
      batch_qc_validation_checking
      flash.keep[:success] = "Task completed!"
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    
    @plasmid_batch_qc.destroy
    batch_qc_validation_checking
    
  end
  

  private

    def set_params
      params.require(:plasmid_batch_qc).permit(:dig_other, :itr, :comments, :conclusion, :plasmid_batch_id , :sma1_id, :pcr_colony_id, :sma1_display,:_destroy, :primer1, :primer2, :date_send,
      :plasmid_batch_attributes =>[:clone_batch_id, :id, :format, :concentration, :comment, :unit_id],
      :clone_batch_attributes => [:id, :name, :promoted, :comment, :qc_validation, :clone_batch_id, :clone_id],
      :clone_attributes => [:id, :name, :assay_id],
      :assay_attributes => [:id, :name],
      :plasmid_batch_qc_attachments_attributes =>[:id,:plasmid_batch_qc_id, :attachment, :remove_attachment, :_destroy],
      :sma1_attributes => [:id, :name],
      :pcr_colony_attributes => [:id, :name]
      )
    end
    
    def load_all
      @plasmid_batch = PlasmidBatch.find(params[:plasmid_batch_id])
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
    
    def batch_qc_validation_checking
      if @plasmid_batch.plasmid_batch_qcs.any? {|qc| qc.conclusion == true}
        @plasmid_batch.update_columns(:qc_validation => true)
      else
        @plasmid_batch.update_columns(:qc_validation => false)
      end
    end
end

