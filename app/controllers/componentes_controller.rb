class ComponentesController < ApplicationController
  def index
    # @evento = Evento.find(params[:evento_id])
    @componentes = Componente.order("inicio asc")
    # @evento = Evento.find(params[:evento_id])
    # @componentes = @evento.componentes.order("componentes.inicio asc")
    # @pessoa = Pessoa.find(params[:pessoa_id])
    # @componentes = @evento.componentes.order("componentes.inicio asc")
  end

  def show
  end

  def edit
  end

  private
  def set_evento
    @componente = Componente.find(params[:id])
  end

  def evento_params
    params.require(:componente).permit(
      :nome, :descricao, :status, :responsavel_id,
      :pessoa_id,
      :componente_id,
      :logo, :banner, :organizacao, :parceiros, :apoio,

      participacoes_attributes:
      [ :id, :evento_id, :pessoa_id, :componente_id, :frequencia, :_destroy],

      componentes_attributes:
      [
        :id, :evento_id, :tipo, :objetivos, :inicio, :nome, :descricao, :vagas, {:publico_ids => []}, {:ministrante_ids => []}, {:ministrante_ids => []}, :publico, :tipo_componente, :local, :status, :_destroy,

        prepostos_attributes:
        [ :id, :evento_id, :pessoa_id, {:responsaveis_delegado_ids => []}, :componente_id, :_destroy],


        periodos_attributes:
        [
          :id, :componente_id, :inicio, :qnt_horas, :_destroy
        ]
      ]
    )

  end
end
