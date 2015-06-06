class EventosController < ApplicationController
  load_and_authorize_resource
  before_action :set_evento, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @eventos = Evento.all
    # @date = params[:month] ? Date.strftime(params[:month]) : Date.today
    @periodos = []
    @eventos.each do |evento|
      evento.periodos.each do |periodo|
        @periodos << periodo
      end
    end
    #respond_with(@eventos)

    respond_to do |format|
      format.html
      format.json { render :json => @events }
    end

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
