json.array!(@paginas) do |pagina|
  json.extract! pagina, :id, :nome, :permalink, :content
  json.url pagina_url(pagina, format: :json)
end
