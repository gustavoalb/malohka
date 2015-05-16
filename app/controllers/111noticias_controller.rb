class NoticiasController < ApplicationController
  load_and_authorize_resource
  before_action :set_noticia, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @noticias = Noticia.new
    @noticias = Noticia.all.order("publicado_em DESC").all
    @destaques = Noticia.where(destaque: true, pauta: true).order("publicado_em DESC").all.new
    @destaques = Noticia.where(destaque: true, pauta: true).order("publicado_em DESC").all
    @aprovaveis = Noticia.where(publicado: false).order("publicado_em DESC").all
    @aprovados = Noticia.where(publicado: true).order("publicado_em DESC").all
    @pautas = Noticia.where(destaque: false, pauta: true).order("publicado_em DESC").all
    @antigas = Noticia.where(destaque: false, pauta: false).order("publicado_em DESC").all
  end

  def show
    #@noticia = Noticia.find(params[:id])
    respond_with(@noticia)
  end

  def new
    @noticia = Noticia.new
    respond_with(@noticia)
  end

  def edit
  end

  def create
    @noticia = Noticia.new(noticia_params)
    @noticia.save
    respond_with(@noticia)
  end

  # def create
  #   @noticia = Noticia.create!(params[:noticia])
  #   respond_to do |format|
  #     format.html { redirect_to noticias_url }
  #     format.js
  #   end
  # end

  def update
    @noticia.update(noticia_params)
    respond_with(@noticia)
  end

  def destroy
    @noticia.destroy
    respond_with(@noticia)
  end

  # def destroy
  #   @noticia.destroy
  #   respond_to do |format|
  #     format.html { redirect_to noticias_url }
  #     format.js
  #   end
  # end

  private
  def set_noticia
    @noticia = Noticia.find(params[:id])
  end

  def noticia_params
    params.require(:noticia).permit(:titulo, :conteudo, :publicado_em, :publicado, :destaque, :pauta)
  end
end
