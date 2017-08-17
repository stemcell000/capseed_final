json.array!(@clone_batch_attachments) do |clone_batch_attachment|
  json.extract! clone_batch_attachment, :id
  json.url clone_batch_attachment_url(clone_batch_attachment, format: :json)
end
