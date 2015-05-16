json.array!(@cursos) do |curso|
  json.extract! curso, :id, :nome, :codigo, :nivel_id
  json.url curso_url(curso, format: :json)
end
