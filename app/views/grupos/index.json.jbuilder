json.array!(@grupos) do |grupo|
  json.extract! grupo, :id, :nome, :descricao
  json.url grupo_url(grupo, format: :json)
end
