class ComponentesController < ApplicationController
  def index
    @evento = Evento.find(params[:evento_id])
    @componentes = @evento.componentes.order("componentes.inicio asc")
    # @pessoa = Pessoa.find(params[:pessoa_id])
    # @componentes = @evento.componentes.order("componentes.inicio asc")
  end

  def show
  end

  def edit
  end
end
