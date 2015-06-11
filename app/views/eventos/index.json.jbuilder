json.array!(@periodos) do |evento|
  json.extract! evento, :id
  json.start evento.inicio
  json.end evento.termino
  json.title evento.nome
  json.url evento_url(evento, format: :html)
end


