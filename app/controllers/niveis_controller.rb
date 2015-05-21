class NiveisController < ApplicationController
  load_and_authorize_resource
  before_action :set_nivel, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @niveis = Nivel.all.order("nome ASC")
    respond_with(@niveis)
  end

  def show
    respond_with(@nivel)
  end

  def new
    @nivel = Nivel.new
    respond_with(@nivel)
  end

  def edit
  end

  def create
    @nivel = Nivel.new(nivel_params)
    @nivel.save
    respond_with(@nivel)
  end

  def update
    @nivel.update(nivel_params)
    respond_with(@nivel)
  end

  def destroy
    @nivel.destroy
    respond_with(@nivel)
  end

  private
  def set_nivel
    @nivel = Nivel.find(params[:id])
  end

  def nivel_params
    params.require(:nivel).permit(:nome, :codigo)
  end
end
