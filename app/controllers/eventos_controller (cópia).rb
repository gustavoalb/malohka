class EventosController < ApplicationController
  load_and_authorize_resource
  #load_and_authorize_resource :except => [:create]
  before_action :set_evento, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @eventos = Evento.all
    @date = params[:month] ? Date.strftime(params[:month]) : Date.today
    respond_with(@eventos)
  end

  def show
    respond_with(@evento)
  end

#  def new
#    @evento = Evento.new
#    respond_with(@evento)
#  end

  def edit
  end

  def new
    @evento = Evento.new
#    1.times do
#      periodo = @evento.periodos.build
    end
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
#      params.require(:evento).permit(:nome, :tipoevento, :termino, :coordenacao, :departamento_id, :contato, :tipopublico, :participantes, :equipamentos, :observacoes, :deferido, :justificativa, :ativo,
#       ocasioes_attributes: [ :id, :inicio, :termino, :_destroy],
#       periodos_attributes: [ :id, :inicio, :comeco, :_destroy])
    end
end
