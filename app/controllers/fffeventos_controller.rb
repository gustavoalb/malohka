class EventosController < ApplicationController
  load_and_authorize_resource
  before_action :set_evento, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @periodos = Periodo.all
    @pessoa = current_usuario.pessoa
    @participacoes = Participacao.all

    # @date = params[:month] ? Date.strftime(params[:month]) : Date.today
    #   @periodos = []
    #   @eventos.each do |evento|
    #     evento.periodos.each do |periodo|
    #       @periodos << periodo
    #     end
    #   end
    #   #respond_with(@eventos)

    #   respond_to do |format|
    #     format.html
    #     format.json { render :json => @eventos }
    #   end

    # ano_inicio,mes_inicio,dia_inicio = params['start'].split("-") if params['start']
    # ano_fim,mes_fim,dia_fim = params['end'].split("-") if params['end']
    # inicio = Time.new(ano_inicio,mes_inicio,dia_inicio)
    # fim = Time.new(ano_fim,mes_fim,dia_fim)
    # @eventos = Evento.scoped
    # @eventos = Evento.entre(inicio, fim) if (inicio && fim)

  end

  def show
    @participacoes = Participacao.all
    @periodos = Periodo.all
    respond_with(@evento)
  end

  def new
    @evento = Evento.new
    @pessoa = current_usuario.pessoa

    2.times do
      componente = @evento.componentes.build
      4.times { componente.periodos.build }
    end

    # 3.times do
    #   componente = @evento.componentes.build
    #   4.times { componente.periodos.build }
    # end
  end

  def edit
  end

  def create
    @evento = Evento.new(evento_params)
    @evento.save
    respond_with(@evento)
  end

  def update
    @evento.update(evento_params)
    respond_with(@evento)
  end

  def destroy
    @evento.destroy
    respond_with(@evento)
  end

  def inscricao_atividade
    @participacao = Periodo.find(params[:periodo_id])
    @participante = Pessoa.find(params[:id])
  end

  private
  def set_evento
    @evento = Evento.find(params[:id])
  end

  def evento_params
    params.require(:evento).permit(:nome, :descricao, :status, :pessoa_id, :responsavel_id,
                                   componentes_attributes: [ :id, :evento_id, :nome, :qnt_horas, :descricao, :status, :ministrante_id, :_destroy,
                                                             periodos_attributes: [ :id, :evento_id, :inicio, :termino, :qnt_horas, :componente, :descricao]
                                                             ])
  end
end
