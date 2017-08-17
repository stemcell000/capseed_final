json.array!(@vol_units) do |vol_unit|
  json.extract! vol_unit, :id
  json.url vol_unit_url(vol_unit, format: :json)
end
