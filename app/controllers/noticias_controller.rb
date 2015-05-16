class NoticiasController < ApplicationController
  load_and_authorize_resource
  before_action :set_noticia, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @noticias = Noticia.all
    respond_with(@noticias)
  end

  def show
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

  # def update
  #   @noticia.update(noticia_params)
  #   respond_with(@noticia)
  # end

  def update
    @noticia = Noticia.find params[:id]

    respond_to do |format|
      if @noticia.update_attributes(noticia_params)
        format.html { redirect_to(@noticia, :notice => 'Notícia atualizada com successo.') }
        format.json { respond_with_bip(@noticia) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@noticia) }
      end
    end
  end






  def destroy
    @noticia.destroy
    respond_with(@noticia)
  end

  # def toggle_destaque
  #   @a = Noticia.find(params[:id])
  #   @a.toggle!(:destaque)
  #   render :nothing => true
  # end
  def atualizar_status
    @noticia = Noticia.find(params[:noticia_id])
    if params[:status]=='em_destaque'
      @noticia.em_destaque
    elsif params[:status]=='em_pauta'
      @noticia.em_pauta
    end
    redirect_to @noticia
  end

  private
  def set_noticia
    @noticia = Noticia.find(params[:id])
  end

  def noticia_params
    params.require(:noticia).permit(:titulo, :conteudo, :publicado_em, :publicado, :destaque, :pauta,:status)
  end
end
