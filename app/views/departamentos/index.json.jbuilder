json.array!(@departamentos) do |departamento|
  json.extract! departamento, :id, :nome, :sigla, :reparticao_id, :data_criacao, :portaria_criacao
  json.url departamento_url(departamento, format: :json)
end
