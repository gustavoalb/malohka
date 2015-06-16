json.array!(@periodos) do |evento|
  json.extract! evento
  json.start evento.inicio
  json.title evento.nome
  json.end evento.termino
end
