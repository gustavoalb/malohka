class PessoasController < ApplicationController
  load_and_authorize_resource
  before_action :set_pessoa, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    # @pessoas = Pessoa.all
    # respond_with(@pessoas)
    @q = Pessoa.ransack(params[:q])
    @pessoas = @q.result(distinct: true)
  end

  def show
    respond_with(@pessoa)
  end

  def new
    @pessoa = Pessoa.new
    respond_with(@pessoa)
  end

  def edit
  end

  def create
    @pessoa = Pessoa.new(pessoa_params)
    @pessoa.save
    respond_with(@pessoa)
  end

  def update
    @pessoa.update(pessoa_params)
    respond_with(@pessoa)
  end

  def destroy
    @pessoa.destroy
    respond_with(@pessoa)
  end

  private
  def set_pessoa
    @pessoa = Pessoa.find(params[:id])
  end

  def pessoa_params
    params.require(:pessoa).permit(:nome, :cpf, :nascimento, :rg, :email, :fator_rh, :foto, :atualizado, :telefone, :atualizado, :status)
  end
end
