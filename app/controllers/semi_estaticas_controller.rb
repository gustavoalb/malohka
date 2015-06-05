class SemiEstaticasController < ApplicationController
  load_and_authorize_resource #:except=> [:index]
  before_action :set_pagina, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @paginas = Pagina.all
    #@paginas = Pagina.find_by_permalink!(params[:id])
    respond_with(@paginas)
  end

  def show
    #@pagina = Pagina.find_by_permalink!(params[:id])
    @pagina = Pagina.find(params[:id])
    respond_with(@pagina)
  end

  def edit
    @pagina = Pagina.find(params[:id])
    #@pagina = Pagina.find(params[:permalink])
    #@pagina = Pagina.find_by_permalink!(params[:id])
    #@pagina = Pagina.find_by_permalink!(params[:permalink])
  end

  # def create
  #   @pagina = Pagina.new(pagina_params)
  #   @pagina.save
  #   respond_with(@pagina)
  # end

  def to_param
    #{}"#{permalink.to_s.parameterize}"
    "#{id.to_s.parameterize}"
  end

  def update
    @pagina = Pagina.find(params[:id])
    #@pagina = Pagina.find_by_permalink!(params[:id])
    @pagina.update(pagina_params)
    redirect_to semi_estatica_path(@pagina.id)#respond_with(@pagina)
  end

  private
  def set_pagina
    @pagina = Pagina.find(params[:id])
    #@pagina = Pagina.find_by_permalink!(params[:id])
  end

  def pagina_params
    params.require(:pagina).permit(:nome, :permalink, :content, :conteudo, :tipo, :tipo_id)
  end
end
