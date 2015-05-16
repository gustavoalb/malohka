json.array!(@pesquisas) do |pesquisa|
  json.extract! pesquisa, :id, :nome
  json.url pesquisa_url(pesquisa, format: :json)
end
