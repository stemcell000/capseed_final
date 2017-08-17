class CloneBatchQcAttachmentsController < InheritedResources::Base
  private

    def clone_batch_qc_attachment_params
      params.require(:clone_batch_qc_attachment).permit(:attachment)
    end
end

