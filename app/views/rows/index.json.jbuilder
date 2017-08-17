json.array!(@rows) do |row|
  json.extract! row, :id, :name
  json.url row_url(row, format: :json)
end
