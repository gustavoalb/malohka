class IteracoesController < ApplicationController
  load_and_authorize_resource
  before_action :set_iteracao, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @iteracoes = Iteracao.all
    @iteracoes_nomes = @iteracoes.group_by(&:nome)
    @guts = Gut.all

    respond_with(@iteracoes)
  end

  def show
    respond_with(@iteracao)
  end

  def new
    @iteracao = Iteracao.new
    @iteracao.guts.build
    respond_with(@iteracao)
  end

  def edit
  end

  def create
    @iteracao = Iteracao.new(iteracao_params)
    @iteracao.save
    respond_with(@iteracao)
  end

  def update
    @iteracao = Iteracao.find params[:id]

    respond_to do |format|
      if @iteracao.update_attributes(params[:iteracao])
        format.html { redirect_to(@iteracao, :notice => 'iteracao was successfully updated.') }
        format.json { respond_with_bip(@iteracao) }
      else
        # format.html { render :action => "edit" }
        # format.json { respond_with_bip(@iteracao) }
        format.html { render :action => "show" }
        format.json { render :json => @iteracao.errors.full_messages, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @iteracao.destroy
    respond_with(@iteracao)
  end

  def alterar_status
    @guts = Iteracao.find(params[:iteracao_id]).guts
    #@gut = @guts.find(params[:gut_id])
    @gut = Iteracao.guts.find(params[:gut])
    #@gut = Iteracao.guts.find(params[:gut_id])
    if params[:status]=='avaliado'
      @gut.avaliar
    elsif params[:status]=='finalizado'
      @gut.finalizar
    elsif params[:status]=='reavaliacao'
      @gut.reavaliar
    end
    @iteracao.save
    redirect_to iteracoes_url
  end

  private
  def set_iteracao
    @iteracao = Iteracao.find(params[:id])
    @guts = @iteracao.guts.sort_by{|g|g.total_gut}.reverse
  end

  def iteracao_params
    params.require(:iteracao).permit(:nome, :status, guts_attributes: [ :id, :item, :gravidade, :urgencia, :tendencia, :status, :_destroy])
  end
end
