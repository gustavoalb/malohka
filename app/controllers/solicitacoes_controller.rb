class SolicitacoesController < ApplicationController
  load_and_authorize_resource
  before_action :set_solicitacao, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @pessoa = current_usuario.pessoa
    @solicitacao = Solicitacao.new
    respond_with(@solicitacoes)
  end

  def show
    respond_with(@solicitacao)
  end

  def new
    @solicitacao = Solicitacao.new
    respond_with(@solicitacao)
  end

  def solicitar_ie
    @pessoa = current_usuario.pessoa
    @solicitacao = Solicitacao.new
  end

  def edit
  end

  def create
    if params[:tipo]=='ie' and solicitacao_params[:solicitante_id]
      @solicitante = current_usuario.pessoa.alunos.find(solicitacao_params[:solicitante_id])
      @ie = @solicitante.carteiras.create
      # @solicitacao = Solicitacao.create(solicitavel_id: @ie.id, solicitavel_type: 'Iestudantil', solicitante_id: @solicitante.id)
      @pessoa = current_usuario.pessoa
    end
    #eu aprendedo ajax

    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @solicitacao.update(solicitacao_params)
    respond_with(@solicitacao)
  end

  def destroy
    @solicitacao.destroy
    respond_with(@solicitacao)
  end

  private
  def set_solicitacao
    @solicitacao = Solicitacao.find(params[:id])
  end

  def solicitacao_params
    params.require(:solicitacao).permit(:solicitante_id,:finalizado)
  end
end
