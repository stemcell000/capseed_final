class CloneBatchAttachmentsController < InheritedResources::Base

  private

    def clone_batch_attachment_params
      params.require(:clone_batch_attachment).permit()
    end
end

