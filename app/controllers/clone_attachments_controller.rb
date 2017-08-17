class CloneAttachmentsController < InheritedResources::Base

  private

    def clone_attachment_params
      params.require(:clone_attachment).permit(:clone_id, :attachment)
    end
end

