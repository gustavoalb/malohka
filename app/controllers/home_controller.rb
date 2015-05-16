class HomeController < ApplicationController

  def principal
    @destaques = Noticia.where(destaque: true, pauta: true)
    @pautas = Noticia.where(destaque: false, pauta: true)
    @eventos = Evento.all
  end
end
