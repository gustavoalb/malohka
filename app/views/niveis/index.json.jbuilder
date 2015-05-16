json.array!(@niveis) do |nivel|
  json.extract! nivel, :id, :nome, :codigo
  json.url nivel_url(nivel, format: :json)
end
