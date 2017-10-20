json.array!(@qc_attachments) do |qc_attachment|
  json.extract! qc_attachment, :id, :attachment
  json.url qc_attachment_url(qc_attachment, format: :json)
end
