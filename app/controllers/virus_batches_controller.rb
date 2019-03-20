class VirusBatchesController < InheritedResources::Base

 def new_from_inventory
    @virus_batch = VirusBatch.new
    @virus_production = VirusProduction.find(params[:virus_production_id])
    nb = @virus_production.virus_batches.size+1
    @boxes = Box.where.not(:name => "Garbage")
    @columns = Column.all
    @rows = Row.all
    @name = @virus_production.number+"."+nb.to_s
end

def create_from_inventory
    @virus_batch = VirusBatch.create(virus_batch_params)
    @virus_production = VirusProduction.find(params[:virus_production_id])
    if  @virus_batch.valid?
        @virus_production.virus_batches << @virus_batch
        flash.keep[:success] = "Task completed!"
        @virus_batches = @virus_production.virus_batches
    else
        render :action => 'new_from_inventory'
    end
end


def edit_from_inventory
  @virus_batch = VirusBatch.find(params[:id])
  @virus_production = VirusProduction.find(params[:virus_production_id])
    @boxes = Box.all
    @columns = Column.all
    @rows = Row.all
end


def update_from_inventory
  @virus_batch = VirusBatch.find(params[:id])
  @virus_production  = VirusProduction.find(params[:virus_production_id])
  @virus_batches = @virus_production.virus_batches
  @virus_batch.update_attributes(virus_batch_params)
  
  if @virus_batch.valid?
    @units = Unit.all
    flash.keep[:success] = "Task completed!"
  else
    render :action => 'edit_from_inventory'
   end
end 


 def destroy_from_inventory
  @virus_batch = VirusBatch.find(params[:id])
  @virus_production  = VirusProduction.find(params[:virus_production_id])
  @virus_batches = @virus_production.virus_batches
    @virus_batch.toggle!(:trash)
    @virus_batch.update_columns(:volume => 0)
    garbage = Box.find_by_name("Garbage")
    
    unless @virus_batch.trash
      @virus_batch.update_columns(:volume => 0)
      garbage.virus_batches << @virus_batch
     else
      garbage.virus_batches.delete(@virus_batch)
     end
     
      @row = @virus_batch.row
      @column = @virus_batch.column
      if @row 
        @row.virus_batches.delete(@virus_batch)
      end
      if @column
        @column.virus_batches.delete(@virus_batch)
      end
  end
  
  private

    def virus_batch_params
      params.require(:virus_batch).permit(:id, :name, :volume, :virus_production_id, :box_id, :row_id, :column_id, :vol_unit_id, :comment, :date, :date_of_thawing)
    end
    
end

