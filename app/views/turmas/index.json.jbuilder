json.array!(@turmas) do |turma|
  json.extract! turma, :id, :nome, :codigo, :turno, :curso_id
  json.url turma_url(turma, format: :json)
end
