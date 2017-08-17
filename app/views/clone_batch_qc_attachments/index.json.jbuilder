json.array!(@clone_batch_qc_attachments) do |clone_batch_qc_attachment|
  json.extract! clone_batch_qc_attachment, :id, :attachment
  json.url clone_batch_qc_attachment_url(clone_batch_qc_attachment, format: :json)
end
