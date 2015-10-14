json.array!(@reparticoes) do |reparticao|
  json.extract! reparticao, :id, :nome, :sigla, :descricao, :data_criacao
  json.url reparticao_url(reparticao, format: :json)
end
