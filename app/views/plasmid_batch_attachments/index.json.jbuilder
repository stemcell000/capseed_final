json.array!(@plasmid_batch_attachments) do |plasmid_batch_attachment|
  json.extract! plasmid_batch_attachment, :id
  json.url plasmid_batch_attachment_url(plasmid_batch_attachment, format: :json)
end
