json.array!(@plasmid_batch_qc_attachments) do |plasmid_batch_qc_attachment|
  json.extract! plasmid_batch_qc_attachment, :id, :attachment
  json.url plasmid_batch_qc_attachment_url(plasmid_batch_qc_attachment, format: :json)
end
