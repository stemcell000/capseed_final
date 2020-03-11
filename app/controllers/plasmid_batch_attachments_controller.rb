class PlasmidBatchAttachmentsController < InheritedResources::Base

  private

    def plasmid_batch_attachment_params
      params.require(:plasmid_batch_attachment).permit()
    end
end

