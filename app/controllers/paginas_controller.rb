class PaginasController < ApplicationController
  load_and_authorize_resource :except=> [:permalink]
  before_action :set_pagina, only: [:show]

  respond_to :html

  def index
    @paginas = Pagina.all
    #@paginas = Pagina.find_by_permalink!(params[:id])
    respond_with(@paginas)
  end

  def show
    @pagina = Pagina.find_by_permalink!(params[:id])
    #@pagina = Pagina.find(params[:id])
    respond_with(@pagina)
  end

  def permalink
    @pagina = Pagina.where(tipo:params[:tipo],permalink:params[:permalink]).first
    #@pagina = Pagina.find(params[:id])
    respond_to do |format|
      format.html
    end

  end

  def new
    @pagina = Pagina.new
    respond_with(@pagina)
  end

  def edit
    #@pagina = Pagina.find(params[:id])
    @pagina = Pagina.find(params[:id])
    #@@pagina = Pagina.find_by_permalink!(params[:id])
    #@pagina = Pagina.find_by_permalink!(params[:permalink])
  end

  def create
    @pagina = Pagina.new(pagina_params)
    @pagina.save
    respond_with(@pagina)
  end

  def update
    @pagina = Pagina.find(params[:id])
    #@pagina = Pagina.find_by_permalink!(params[:id])
    @pagina.update(pagina_params)
    respond_with(@pagina)
  end

  def destroy
    @pagina = Pagina.find(params[:id])
    #@pagina = Pagina.find_by_permalink!(params[:id])
    @pagina.destroy
    respond_with(@pagina)
  end

  private
  def set_pagina
    #@pagina = Pagina.find(params[:id])
    @pagina = Pagina.find_by_permalink!(params[:id])


  end

  def pagina_params
    params.require(:pagina).permit(:nome, :permalink, :content, :conteudo, :tipo, :tipo_id)
  end
end
