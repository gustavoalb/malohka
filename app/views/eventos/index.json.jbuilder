json.array!(@eventos) do |evento|
  json.extract! evento, :id, :nome, :descricao, :status, :responsavel_id, :pessoa_id
  json.url evento_url(evento, format: :json)
end
