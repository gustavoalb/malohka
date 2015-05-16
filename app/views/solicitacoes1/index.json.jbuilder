json.array!(@solicitacoes) do |solicitacao|
  json.extract! solicitacao, :id, :solicitante_id, :tipo_objeto_id, :tipo_objeto_type, :finalizado
  json.url solicitacao_url(solicitacao, format: :json)
end
