class SolicitacoesController < ApplicationController
  load_and_authorize_resource
  before_action :set_solicitacao, only: [:show, :edit, :update, :destroy]
  #before_action :atualizar_aluno

  respond_to :html

  def index
    @pessoa = current_usuario.pessoa
    #@aluno = @pessoa.alunos.first
    @solicitacao = Solicitacao.new
    #respond_with(@solicitacoes)
    if @pessoa.status == 'pendente' and @pessoa.alunos.first.status == 'pendente'
      #if current_usuario.roles_mask == 4 and @pessoa.status == 'pendente' and @aluno.status == 'pendente'
      #if @pessoa.status == 'pendente'
      redirect_to validacao_index_path
    elsif @pessoa.status = 'atualizado'
      respond_with(@solicitacoes)
    end
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
