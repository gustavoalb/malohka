class EventosController < ApplicationController
  load_and_authorize_resource
  before_action :set_evento, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @periodos = Periodo.all

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
    respond_with(@evento)
  end

  def new
    @evento = Evento.new
    3.times { @evento.periodos.build }
    #respond_with(@evento)
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

  private
  def set_evento
    @evento = Evento.find(params[:id])
  end

  def evento_params
    params.require(:evento).permit(:nome, periodos_attributes: [ :id, :inicio, :termino,:_destroy] )
  end
end
