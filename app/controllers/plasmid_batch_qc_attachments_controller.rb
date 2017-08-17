class PlasmidBatchQcAttachmentsController < InheritedResources::Base

  private

    def plasmid_batch_qc_attachment_params
      params.require(:plasmid_batch_qc_attachment).permit(:attachment)
    end
end

