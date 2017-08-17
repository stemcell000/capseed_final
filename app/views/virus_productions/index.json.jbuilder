json.array!(@virus_productions) do |virus_production|
  json.extract! virus_production, :id, :date_order, :date_production, :user_id, :plate_nb, :vol, :sterility, :plate_id
  json.url virus_production_url(virus_production, format: :json)
end
