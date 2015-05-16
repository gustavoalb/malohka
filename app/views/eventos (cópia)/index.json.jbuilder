json.array!(@eventos) do |evento|
  json.extract! evento, :id, :nome, :tipoevento, :inicio, :termino, :coordenacao, :departamento_id, :contato, :tipopublico, :participantes, :equipamentos, :observacoes, :deferido, :justificativa, :ativo
  json.url evento_url(evento, format: :json)
end
