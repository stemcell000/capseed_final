class QcAttachmentsController < InheritedResources::Base
  private

    def qc_attachment_params
      params.require(:qc_attachment).permit(:attachment)
    end
end

