json.array!(@publicos) do |publico|
  json.extract! publico, :id, :nome, :descricao
  json.url publico_url(publico, format: :json)
end
