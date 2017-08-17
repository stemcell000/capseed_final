class CloneBatchAsPlasmidAttachmentsController < InheritedResources::Base

  private

    def clone_batch_as_plasmid_attachment_params
      params.require(:clone_batch_as_plasmid_attachment).permit()
    end
end

