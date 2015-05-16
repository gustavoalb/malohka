json.array!(@alunos) do |aluno|
  json.extract! aluno, :id, :nome, :nascimento, :rg, :matricula, :cpf, :telefone, :endereco, :ano_ingresso, :turma_id
  json.url aluno_url(aluno, format: :json)
end
