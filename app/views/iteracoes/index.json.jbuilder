json.array!(@iteracoes) do |iteracao|
  json.extract! iteracao, :id, :nome, :status
  json.url iteracao_url(iteracao, format: :json)
end
