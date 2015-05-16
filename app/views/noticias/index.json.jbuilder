json.array!(@noticias) do |noticia|
  json.extract! noticia, :id, :titulo, :conteudo, :publicado_em, :publicado, :destaque, :pauta
  json.url noticia_url(noticia, format: :json)
end
