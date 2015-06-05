json.array!(@funcionarios) do |funcionario|
  json.extract! funcionario, :id, :matricula, :cargo, :cargo_id, :data_posse, :pessoa_id
  json.url funcionario_url(funcionario, format: :json)
end
