json.array!(@ministrantes) do |ministrante|
  json.extract! ministrante, :id, :pessoa_id, :nome, :organizacao, :biografia
  json.url ministrante_url(ministrante, format: :json)
end
