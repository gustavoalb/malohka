class FuncionariosController < ApplicationController
  before_action :set_funcionario, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @funcionarios = Funcionario.all
    respond_with(@funcionarios)
  end

  def show
    respond_with(@funcionario)
  end

  def new
    @funcionario = Funcionario.new
    respond_with(@funcionario)
  end

  def edit
  end

  def create
    @funcionario = Funcionario.new(funcionario_params)
    @funcionario.save
    respond_with(@funcionario)
  end

  def update
    @funcionario.update(funcionario_params)
    respond_with(@funcionario)
  end

  def destroy
    @funcionario.destroy
    respond_with(@funcionario)
  end

  private
    def set_funcionario
      @funcionario = Funcionario.find(params[:id])
    end

    def funcionario_params
      params.require(:funcionario).permit(:matricula, :cargo, :cargo_id, :data_posse, :pessoa_id)
    end
end
