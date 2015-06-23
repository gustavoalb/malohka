class IteracoesController < ApplicationController
  load_and_authorize_resource
  before_action :set_iteracao, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @iteracoes = Iteracao.all
    @iteracoes_nomes = @iteracoes.group_by(&:nome)
    @guts = Gut.all

    #@total = @gut[:gravidade] + @gut[:urgencia] + @gut[:tendencia]
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

  # def update
  #   @iteracao.update(iteracao_params)
  #   respond_with(@iteracao)
  # end

  def update
    @iteracao = Iteracao.find params[:id]

    respond_to do |format|
      if @iteracao.update_attributes(params[:iteracao])
        format.html { redirect_to(@iteracao, :notice => 'iteracao was successfully updated.') }
        format.json { respond_with_bip(@iteracao) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@iteracao) }
      end
    end
  end


  def destroy
    @iteracao.destroy
    respond_with(@iteracao)
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
