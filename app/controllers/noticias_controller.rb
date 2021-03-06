class NoticiasController < ApplicationController
  load_and_authorize_resource
  before_action :set_noticia, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    #@noticias = Noticia.all
    #respond_with(@noticias)
    @q = Noticia.ransack(params[:q])
    #@noticias = @q.result(distinct: true)
    @noticias = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 5).order("publicado_em ASC")
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

  def update
    @noticia = Noticia.find params[:id]

    respond_to do |format|
      if @noticia.update_attributes(noticia_params)
        #format.html { redirect_to(@noticia, :notice => 'Notícia atualizada com successo.') }
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

  def alterar_status
    @noticia = Noticia.find(params[:noticia_id])
    if params[:status]=='destaque'
      @noticia.em_destaque
      @noticia.publicado_em = DateTime.now
    elsif params[:status]=='pauta'
      @noticia.em_pauta
    elsif params[:status]=='arquivo'
      @noticia.em_arquivo
    elsif params[:status]=='reavaliacao'
      @noticia.reavaliar
    end
    @noticia.save
    redirect_to noticias_url
  end

  private
  def set_noticia
    @noticia = Noticia.find(params[:id])
  end

  def noticia_params
    params.require(:noticia).permit(:titulo, :conteudo, :publicado_em, :tag_list, :status)
  end
end
