class VirusBatchesController < InheritedResources::Base

 def new_from_inventory
    @virus_batch = PlasmidBatch.new
    @virus_production = VirusProduction.find(params[:virus_production_id])
    nb = @virus_production.virus_batches.size+1
    @boxes = Box.all
    @columnss = Column.all
    @rows = Row.all
    @name = @virus_production.id.to_s+"."+nb.to_s
end

def create_from_inventory
    @virus_batch = PlasmidBatch.create(set_params)
    @viruses = User.all
    @virus_production = VirusProduction.find(params[:virus_production_id])
    if  @virus_batch.valid?
        @virus_production.virus_batches << @virus_batch
        flash.keep[:success] = "Task completed!"
        @virus_batches = @virus_production.virus_batches
    else
        render :action => 'new_from_inventory'
    end
end

  private

    def virus_batch_params
      params.require(:virus_batch).permit(:name, :virus_production_id, :box_id, :row_id, :column_id)
    end
    
     def set_params
      params.require(:plasmid_batch).permit(:clone_batch_id, :id, :number, :name, :volume, :format, :concentration, :comment, :unit_id , :vol_unit_id, :box_id, :row_id, :column_id, :production_id, :format_id,
      :user_id, :strict_validation , :_destroy, :trash,
      
      :plasmid_batch_attachments_attributes =>[:id,:plasmid_batch_id, :attachment, :remove_attachment, :_destroy],
      
      :clone_attributes => [:id, :name, :assay_id],
      
      :assay_attributes => [:id, :name],
      
      :vol_unit_attributes =>[:id, :plasmid_batch_id, :name],
      
      :plasmid_batch_qcs_attributes =>[:id, :dig_saml, :dig_other, :comments, :conclusion],
      
      :production_attributes => [:id, :name, :plasmid_batch_id],
      
      :box_attributes => [:id, :name],
      
      :row_attributes => [:id, :name],
      
      :column_attributes => [:id, :name],
      
      :format_attributes => [:id, :name],
      
      :user_attributes => [:id, :username, :firstname, :lastname, :full_name])
    end
end

