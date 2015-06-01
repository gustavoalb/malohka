json.array!(@photos) do |photo|
  json.extract! photo, :id, :descricao
  json.url photo_url(photo, format: :json)
end
